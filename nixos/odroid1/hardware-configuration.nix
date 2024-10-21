# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    # https://nixos.wiki/wiki/ZFS#Importing_pools_at_boot
    zfs.extraPools = [ "dpool" ];
  };
  # https://nixos.wiki/wiki/ZFS#Automatic_scrubbing
  # Recommended; scrubs pools once a week
  services.zfs.autoScrub.enable = true;
  services.sanoid = {
    enable = true;
    datasets.dpool = {
      recursive = true ;
      process_children_only = true;
      use_template = [ "production" ];
    };
    templates.production = {
      hourly = 36;
      daily = 30;
      monthly = 3;
      yearly = 0;
      autosnap = true;
      autoprune = true;
    };
  };

  fileSystems = {
    "/" =
      {
        device = "rpool/safe/system/root";
        fsType = "zfs";
      };

    "/boot" =
      {
        device = "/dev/disk/by-uuid/979B-0F62";
        fsType = "vfat";
      };

    "/nix" =
      {
        device = "rpool/local/nix";
        fsType = "zfs";
      };

    "/var" =
      {
        device = "rpool/safe/system/var";
        fsType = "zfs";
      };

    "/home/iancleary" =
      {
        device = "rpool/safe/home/iancleary";
        fsType = "zfs";
      };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
