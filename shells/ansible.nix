{ pkgs, ... }:

pkgs.mkShellNoCC {
  nativeBuildInputs = with pkgs; [
    ansible_2_14
    openssh
    actionlint
    selene
    stylua
    statix
    nixpkgs-fmt
    yamllint
  ];
}
