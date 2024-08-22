{ inputs, ... }:
{
  imports = [
    inputs.terminal-config.homeManagerModules.default
  ];
}
