{ config, pkgs, lib, ... }:
let
  openWebuiImage = "ghcr.io/open-webui/open-webui:main";
in
{
  virtualisation.oci-containers = {
    backend = {
      image = openWebuiImage;
      cmd = [ "-d" "--network=host" "-v" "open-webui:/app/backend/data" "--name" "open-webui" "--restart" "always" ];
      volumes = [ "open-webui:/app/backend/data" ];
      environment = {
        OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      };
      restart = "always";
    };
  };

  services.nginx.virtualHosts."chat.${config.networking.hostName}.${config.networking.domain}" = {
      forceSSL = true;
      #useACMEHost = config.networking.domain; #not sure if this will work, unless
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://${config.services.ollama.listenAddress}";
      };
      basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
  };
}