{ config, pkgs, lib, ... }:

let
  hostname = config.networking.hostName;
in

{
  # Add Ollama to system packages
  environment.systemPackages = [ pkgs.unstable.ollama ];

  # Ollama configuration
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    host = "0.0.0.0";
    openFirewall = true;
    port = 11434;
    home = "/var/lib/ollama";

    # Preloaded models
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

    # Acceleration settings
    acceleration = "cuda"; 

  };
  # NGINX reverse proxy configuration
  services.nginx.virtualHosts."ollama.${config.networking.hostName}.${config.networking.domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyWebsockets = true;
      proxyPass = "http://${config.services.ollama.listenAddress}";
    };
    basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
  };
}
