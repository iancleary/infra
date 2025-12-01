# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.hardkernel-odroid-h3
    ./hardware-configuration.nix
    ./networking.nix # this could be below since it's not machine specific
    #./nextcloud.nix
    ./tailscale.nix # this is the customization for this server
    # below are system setup, ports, virtualization, etc.
  ];

  mySystem = {
    tailscale = {
      enable = true;
      unstable = true;
    };
    home-manager = {
      enable = true;
      home = ./home.nix;
    };
  };

  boot = {
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Latest kernel for ZFS
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };
  networking = {
    hostName = "odroid2"; # Define your hostname.
    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    # ZFS
    hostId = "8425e349";
  };
  # Set your time zone.
  # time.timeZone = "America/Phoenix";

  users = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    # don't allow mutation of users outside of config
    mutableUsers = false;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.iancleary = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
      # initialPassword = "password";
      initialHashedPassword = "$y$j9T$Ov2T/rXjvlEr48/5akCcx0$xOvKr97FRq9TLPLVKhEC7rtF7sfvOwpeL2/DC4a2vO1";
    };
  };
  # packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # for ansible configuration
    # it's located here so this configuration can be copy
    # and pasted into a new system, without ansible
    (
      python312.withPackages (
        ps: with ps; [
          # for community.docker.docker_image
          # and community.docker.docker_compose_v2
          requests
        ]
      )
    )
    smartmontools
  ];


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
