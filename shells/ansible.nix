{ pkgs, ... }:

pkgs.mkShellNoCC {
  nativeBuildInputs = with pkgs; [
    uv # ansible uses ./ansible/pyproject.toml and ./ansible/uv.lock for ansible
    openssh
    actionlint
    selene
    stylua
    statix
    nixpkgs-fmt
    yamllint
  ];
}
