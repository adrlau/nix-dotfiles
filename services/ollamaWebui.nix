{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.open-webui
    pkgs.gvisor

  ];

  services.tika.enable=true;
  services.tika.openFirewall=true;
  services.tika.listenAddress = "localhost";

  
  services.open-webui = {
    enable = true;

    package = pkgs.unstable.open-webui;
    port = 11111;
    host = "0.0.0.0";
    openFirewall = true;

    enviroment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      PDF_EXTRACT_IMAGES = "False";
    };

  };
}
