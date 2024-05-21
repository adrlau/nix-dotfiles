{ config, pkgs, lib, ... }:
{
#  environment.systemPackages = [
#    pkgs.freshrss
#  ];
#  services.freshrss = {
#      enable = true;
#      baseUrl = "http://0.0.0.0";
#      passwordFile = config.sops.secrets."freshrss/passwordFile".path; #"/run/secrets/freshrss";  
#  };
#
    sops.secrets."miniflux/adminCredentialsFile" = {
      restartUnits = [ "miniflux.service" ];
#      owner = "miniflux";
      mode = "0755";
    };



    services.miniflux.enable = true; 
    services.miniflux.config.LISTEN_ADDR = "0.0.0.0:8081";
    services.miniflux.adminCredentialsFile = config.sops.secrets."miniflux/adminCredentialsFile".path;

}
