{ config, pkgs, lib, ... }:

let
  unstable = import
    (builtins.fetchTarball "https://github.com/nixos/nixpkgs/tarball/nixos-unstable")
    { inherit (config.nixpkgs) config; };
in
{
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--ssh"
    ];
    authKeyFile = "/etc/nixos/secrets/tailscale_key";
    package = unstable.tailscale;
  };
}
