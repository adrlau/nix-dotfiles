{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.open-webui
    pkgs.gvisor
    pkgs.bash

  ];

  services.tika = {
    enable=true;
    openFirewall=true;
    listenAddress = "localhost";
    enableOcr = true;
  };
  
  services.open-webui = {
    enable = true;

    package = pkgs.unstable.open-webui;
    port = 11111;
    host = "0.0.0.0";
    openFirewall = true;

    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      PDF_EXTRACT_IMAGES = "False";
    };

  };
}
