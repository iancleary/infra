{ config, pkgs, ... }:

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
        # oh-my-zsh = {
        #     enable = true;
        # };
        plugins = [
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
        ];
    };
  };

  fonts.fontconfig.enable = true;
}