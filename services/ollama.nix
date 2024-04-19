{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.ollama
  ];

  services.ollama.enable = true;
  services.ollama.listenAddress = "0.0.0.0:11434";
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