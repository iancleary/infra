# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
  ];

  # https://github.com/nix-community/home-manager/issues/605#issuecomment-753667922
  fonts.fontconfig.enable = true;

  # fonts.fontDir.enable = true;

  # # https://nixos.wiki/wiki/Fonts
  fonts.fonts = with pkgs; [
    meslo-lgs-nf
  ];

  # https://nixos.wiki/wiki/Command_Shell
  # Many programs look at /etc/shells to determine if a user is a "normal" user and not a "system" user. 
  # Therefore it is recommended to add the user shells to this list. 
  # To add a shell to /etc/shells use the following line in your config:
  environment.shells = with pkgs; [ zsh ];

  # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.enableCompletion
  environment.pathsToLink = [ "/share/zsh" ];

  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;
}
