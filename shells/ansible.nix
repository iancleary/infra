{ pkgs, ... }:

pkgs.mkShellNoCC {
  nativeBuildInputs = with pkgs; [
    ansible_2_15
    openssh
    actionlint
    selene
    stylua
    statix
    nixpkgs-fmt
    yamllint
  ];
}
