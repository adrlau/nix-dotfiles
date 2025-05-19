{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.ollama
  ];

  services.ollama = {
      enable = true;
      package = pkgs.unstable.ollama;
      host = "0.0.0.0";
      openFirewall = true;
      port = 11434;
      home = "/var/lib/ollama";

      loadModels = [
        "gemma3:1b"
        "qwen3:8b"
        "qwen3:0.6b"
        "llama3.1"

        "moondream"
        "minicpm-v"
        "qwen2.5vl:3b"
        "gemma3:4b"
        "granite3.2-vision"


        "zylonai/multilingual-e5-large"
        "nomic-embed-text"
        "snowflake-arctic-embed2"
        
      ];
  };

  #possibly a flawed idea, should just set cudaSupport and rocm support.
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
