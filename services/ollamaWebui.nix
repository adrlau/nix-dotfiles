{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.open-webui
    pkgs.gvisor
    pkgs.bash
    pkgs.unstable.tika

  ];

  services.tika = {
    enable=true;
    package = pkgs.unstable.tika;
    openFirewall=true;
    listenAddress = "0.0.0.0";
    port  = 9998;
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
    };

  };
}
