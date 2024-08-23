{ inputs, ... }:

{
  options = {
    myHome = { };
  };

  imports = [
    inputs.terminal-config.homeManagerModules.default
    ./nextcloud-autosync
  ];
}
