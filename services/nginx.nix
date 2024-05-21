{ config, pkgs, lib, ... }:
{  
  #declare secrets
  sops.secrets."nginx/defaultpass" = {
    restartUnits = [ "nginx.service" ];
    owner = "nginx";
  };
  # services.oauth2_proxy = {
  #   enable = true;
  # }
  #proxy stuff
  services.nginx = {
    enable = true;
    statusPage = true;
    enableReload = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;

    logError = "syslog:server=unix:/dev/log";
    commonHttpConfig = ''
     access_log syslog:server=unix:/dev/log;
    '';
  };
}
