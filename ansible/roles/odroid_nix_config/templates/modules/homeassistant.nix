{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 1883 5353 8123 9541 51827 ];
      # 1883 -> MQTT,
      # 5353 -> mDNS,
      # 8123 Home Assistant Web UI,
      # 9541 -> TasmoAdmin,
      # 51827 -> HomeKit
    };
  };
}
