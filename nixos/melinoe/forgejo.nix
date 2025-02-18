{ config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  # services.nginx = {
  #   virtualHosts."${cfg.settings.server.DOMAIN}" = {
  #     forceSSL = true;
  #     enableACME = true;
  #     locations."/".proxyPass = "http://localhost:${toString srv.HTTP_PORT}";
  #     extraConfig = ''
  #       client_max_body_size 512M;
  #     '';
  #   };
  # };

  services.forgejo = {
    enable = true;
    database.type = "sqlite3";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "melinoe";
        HTTP_PORT = 3000;
        ROOT_URL = "http://${srv.DOMAIN}:${toString srv.HTTP_PORT}";
      };
      actions = {
        ENABLED = true;
      };
      mailer.ENABLED = false;
    };
  };
}
