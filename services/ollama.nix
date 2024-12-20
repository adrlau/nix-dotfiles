{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.ollama
  ];

  services.ollama.enable = true;
  services.ollama.package = pkgs.unstable.ollama;
  services.ollama.host = "0.0.0.0";
  services.ollama.port = 11434;
  services.ollama.models = "/var/lib/ollama/models";
  services.ollama.home = "/var/lib/ollama";
  
  #possibly a flawed idea.
  services.ollama.acceleration = lib.mkDefault (  let
                                                    hostname = config.networking.hostName;
                                                  in
                                                    if hostname == "galadriel" then "cuda"
                                                    else if hostname == "aragorn" then "rocm"
                                                    else null);

  services.nginx.virtualHosts."ollama.${config.networking.hostName}.${config.networking.domain}" = {
      forceSSL = true;
      #useACMEHost = config.networking.domain; #not sure if this will work, unless
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://${config.services.ollama.listenAddress}";
      };
      basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
  };
}
