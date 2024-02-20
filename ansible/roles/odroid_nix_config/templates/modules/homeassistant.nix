{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 1883 5353 8123 51827 ]; # MQTT, mDNS, Home Assistant Web UI, HomeKit
    };
  };
}
