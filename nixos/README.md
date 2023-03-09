# nixos-config

Welcome to my nixos-config!

https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution

https://nixos.wiki/wiki/Home_Manager

https://discourse.nixos.org/t/github-strategies-for-configuration-nix/1983

https://github.com/michaelpj/nixos-config/blob/master/modules/home.nix

https://github.com/NixOS/nixpkgs/issues/154696#issuecomment-1012026159


## Home Manager

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
sudo nix-channel --update
```

It is then possible to add

`imports = [ <home-manager/nixos> ];`
to your system configuration.nix file, which will introduce a new NixOS option called home-manager.users whose type is an attribute set that maps user names to Home Manager configurations.
