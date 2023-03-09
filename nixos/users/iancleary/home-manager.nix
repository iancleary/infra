{ config, pkgs, lib, ... }:

{
  home-manager.users.iancleary = {
    home.stateVersion = "22.11";
    
    home.packages = with pkgs; [
        colorls
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
        # enableSyntaxHighlighting = true;
        
        # https://nixos.org/manual/nix/stable/language/values.html#type-string
        # https://discourse.nixos.org/t/need-help-understanding-how-to-escape-special-characters-in-the-list-of-str-type/11389/4
        initExtraFirst = (builtins.readFile /etc/nixos/modules/common/p10k-config/instant_prompt.zsh);

        # https://discourse.nixos.org/t/using-an-external-oh-my-zsh-theme-with-zsh-in-nix/6142/2
        plugins = [
            {
                name = "zsh-autosuggestions";
                src = pkgs.fetchFromGitHub {
                    owner = "zsh-users";
                    repo = "zsh-autosuggestions";
                    rev = "v0.6.4";
                    sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
                };
            }
            {
                name = "fast-syntax-highlighting";
                src = pkgs.fetchFromGitHub {
                    owner = "zdharma";
                    repo = "fast-syntax-highlighting";
                    rev = "v1.55";
                    sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
                };
            }
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