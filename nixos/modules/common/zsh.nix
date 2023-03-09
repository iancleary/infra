# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    colorls
    oh-my-zsh
    zsh
    zsh-history
    zsh-completions
    zsh-powerlevel10k
    zsh-syntax-highlighting
  ];

  fonts.fontconfig.enable = true;

  # https://nixos.wiki/wiki/Fonts
  fonts.fonts = with pkgs; [
    meslo-lgs-nf
    # noto-fonts
    # noto-fonts-cjk
    # noto-fonts-emoji
    # liberation_ttf
    # fira-code
    # fira-code-symbols
    # mplus-outline-fonts.githubRelease
    # dina-font
    # proggyfonts
  ];

  # https://nixos.wiki/wiki/Command_Shell
  # Many programs look at /etc/shells to determine if a user is a "normal" user and not a "system" user. 
  # Therefore it is recommended to add the user shells to this list. 
  # To add a shell to /etc/shells use the following line in your config:
  environment.shells = with pkgs; [ zsh ];

  # Enable ZSH
  programs.zsh.enable = true;

  # Enable oh-my-zsh
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "gitfast" "yarn" "zsh-syntax-highlighting" "powerlevel10k" ];
  }; 

  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;
}
