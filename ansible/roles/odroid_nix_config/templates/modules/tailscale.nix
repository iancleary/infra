{ config, pkgs, ... }:

{
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--ssh"
    ];
    authKeyFile = "/etc/nixos/secrets/tailscale_key";
  };
}
