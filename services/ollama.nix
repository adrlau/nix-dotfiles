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
        "llama3.2"
        "gemma2:2b"
        "qwen2.5:3b"

        "llama3.2-vision"
        "llava-phi3"
        "llava-llama3"
        "moondream"
        "minicpm-v"

        "llama3.1"
        "mistral-nemo"
        "phi4"

        "zylonai/multilingual-e5-large"
        "nomic-embed-text"
        "snowflake-arctic-embed"
        
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
