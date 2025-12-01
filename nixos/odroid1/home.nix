{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";

  myHome = {
    nextcloud-autosync = {
      enable = false;
    };
  };

  myTerminal = {
    cli.personalGitEnable = true;
    zsh.enable = true;
  };

  # home.packages = with pkgs; [
  # ];
}
