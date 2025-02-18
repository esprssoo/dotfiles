{ ... }:
{
  services.atuin = {
    enable = true;
    database.uri = "sqlite:///var/lib/atuin/server.db?mode=rwc";
    host = "0.0.0.0";
    port = 8888;
    openRegistration = true;
  };

  systemd.services.atuin.serviceConfig.StateDirectory = "atuin";
}
