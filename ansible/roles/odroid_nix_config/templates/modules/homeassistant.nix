{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 1883 5353 8123 8883 9001 9541 21064 21065 51827 ];
      # 1883 -> MQTT,
      # 5353 -> mDNS,
      # 8123 Home Assistant Web UI,
      # 8883 -> MQTT over SSL,
      # 9001 -> MQTT Websockets,
      # 9541 -> TasmoAdmin,
      # 21064 -> Homekit Bridge
      # 21065 -> Homekit Bridge (https://www.home-assistant.io/integrations/homekit/)
      # 51827 -> HomeKit
    };
  };
}
