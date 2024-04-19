{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.wyoming-faster-whisper
    pkgs.whisper
    pkgs.openai-whisper
    pkgs.openai-whisper-cpp
  ];


  services.wyoming.faster-whisper = {
    package = pkgs.wyoming-faster-whisper;

    servers = {
      fast = {
        enable = true;
        model = "tiny-int8";
        uri = "tcp://0.0.0.0:10300";
        device = "cuda";
        language = "en";
        beamSize = 1;
      };
      fast-no = {
        enable = true;
        model = "tiny-int8";
        uri = "tcp://0.0.0.0:10301";
        device = "cuda";
        language = "no";
        beamSize = 1;
      };
      fast-auto = {
        enable = true;
        model = "tiny-int8";
        uri = "tcp://0.0.0.0:10302";
        device = "cuda";
        language = "auto";
        beamSize = 1;
      };
      fast-cpu = {
        enable = true;
        model = "tiny-int8";
        uri = "tcp://0.0.0.0:10303";
        device = "cpu";
        language = "auto";
        beamSize = 1;
      };
      slow = {
        enable = true;
        model = "small";
        uri = "tcp://0.0.0.0:10304";
        device = "auto";
        language = "auto";
        beamSize = 5;
      };
    };
  };

  services.nginx.virtualHosts."whisper.${config.networking.hostName}.${config.networking.domain}" = {
      forceSSL = true;
      #useACMEHost = config.networking.domain; #not sure if this will work, unless
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "${config.services.services.wyoming.faster-whisper.servers.fast.uri}";
      };
      basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
  };
}