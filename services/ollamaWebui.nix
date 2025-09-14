{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    #pkgs.open-webui
    #pkgs.unstable.open-webui #needed stable one to hoefulle be able to take a backup from ui.
    pkgs.bash
    pkgs.ffmpeg
#    pkgs.unstable.tika

  ];

#  services.tika = {
#    enable=true;
#    package = pkgs.unstable.tika;
#    openFirewall=true;
#    listenAddress = "0.0.0.0";
#    port  = 9998;
#    enableOcr = true;
#  };
  
  services.open-webui = {
    enable = true;

    package = pkgs.unstable.open-webui;
    port = 11111;
    host = "0.0.0.0";
    openFirewall = true;
    stateDir = "/var/lib/open-webui";
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      
      FRONTEND_BUILD_DIR = "${config.services.open-webui.stateDir}/build";
      DATA_DIR = "${config.services.open-webui.stateDir}/data";
      STATIC_DIR = "${config.services.open-webui.stateDir}/static";


      WEBUI_AUTH = "True";
      #ENABLE_SIGNUP = "True";
      ENABLE_SIGNUP_PASSWORD_CONFIRMATION = "True";
      #DEFAULT_USER_ROLE = "admin";
      ENV = "prod";
    };

  };
}
