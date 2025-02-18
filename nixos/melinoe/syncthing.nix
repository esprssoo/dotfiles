{ ... }:
let
  tailscaleIf = "tailscale0";
  listenAddressTcp = "tcp://0.0.0.0:22000";
  listenAddressQuic = "quic://0.0.0.0:22000";
in
{
  services.syncthing = {
    enable = true;
    user = "syncthing";
    group = "syncthing";
    dataDir = "/var/lib/syncthing";
    configDir = "/var/lib/syncthing/.config/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    guiAddress = "0.0.0.0:8384";

    # Listen for sync traffic on the standard ports.
    settings.options.listenAddresses = [
      listenAddressTcp
      listenAddressQuic
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/syncthing 0750 syncthing syncthing - -"
    "d /var/lib/syncthing/data 0750 syncthing syncthing - -"
  ];

  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [
      22000
      21027
    ];

    interfaces.${tailscaleIf}.allowedTCPPorts = [ 8384 ];
  };

  # Don't let the module open extra ports automatically; we manage firewall above.
  services.syncthing.openDefaultPorts = false;
}
