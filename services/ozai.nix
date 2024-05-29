{ config, pkgs, lib, ... }:
{

  services.ozai.enable = true;
  services.ozai.host = "0.0.0.0";
  services.ozai.port = 8000;

  services.ozai-webui = {
    enable = true;
    port = 8085;
    host = "0.0.0.0";
  };

  services.nginx.virtualHosts."ozai.${config.networking.hostName}.${config.networking.domain}" = {
      forceSSL = true;
      #useACMEHost = config.networking.domain; #not sure if this will work, unless
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://${config.services.ozai.host}:${config.services.ozai.port}";
      };
  };
}
