{ pkgs, ... }:

{
  mySystem = {
    user = "nixos";
    home-manager = {
      enable = true;
      home = ./home.nix;
    };
  };
}
