{ inputs, ... }:

{
  options = {
    myHome = {
    };
  };

  imports = [
    inputs.terminal-config.homeManagerModules.default
  ];
}
