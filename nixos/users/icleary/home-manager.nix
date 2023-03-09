{ config, pkgs, lib, ... }:

{
  home-manager.users.icleary = {
    home.stateVersion = "22.11";
    
    home.packages = with pkgs; [
        colorls
        zsh-git-prompt
        zsh-nix-shell
        zsh-completions
        zsh-command-time
        zsh-powerlevel10k
        zsh-fast-syntax-highlighting
        nix-zsh-completions
    ];
    
    programs.zsh = {
        enable = true;
        shellAliases = {
        l = "ls -alh";
        ll = "ls -l";
        ls = "colorls";
        };
        # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        # https://discourse.nixos.org/t/using-an-external-oh-my-zsh-theme-with-zsh-in-nix/6142/2
        plugins = [
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
            {
                name = "powerlevel10k-config";
                # src is relative to the directory you run `sudo nixos-rebuild x` from,
                # not relative to the /etc/nixos/configuration.nix file!
                src = lib.cleanSource /etc/nixos/modules/common/p10k-config;
                file = "p10k.zsh";
            }
        ];
    };
  }; 
}