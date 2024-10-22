{
  services.tailscale = {
    extraUpFlags = [
      # "--stateful-filtering=false"
      "--ssh"
    ];
    authKeyFile = "/etc/nixos/secrets/tailscale_key";
  };
}
