{ config, pkgs, lib, ... }:
{
  services.nginx =  {
    virtualHosts."managment.funn-nas.lauterer.it" = {
      forceSSL = true;
      useACMEHost = config.networking.domain;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "https://100.104.182.48";
      };
      basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
    };

    virtualHosts."funn-nas.lauterer.it" = {
      forceSSL = true;
      useACMEHost = config.networking.domain;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "https://100.104.182.48:30044";
      };
      basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
    };
    
    virtualHosts."home.lauterer.it" = {
      forceSSL = true;
      useACMEHost = config.networking.domain;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://10.0.0.32:8123";
      };
      # ignorerer sikkerhet for littegran for å oprettholde lettvinthet og app kompatibilitet.
      #basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
    };

     virtualHosts."jellyfin.lauterer.it" = {
        forceSSL = true;
        useACMEHost = config.networking.domain;
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://100.84.215.84:8096";
        };
      }; 

      virtualHosts."minecraft.256.no" = {
  	 forceSSL = true;
  	 useACMEHost = config.networking.domain;
  	 locations."/" = {
  	   proxyWebsockets = true;
  	   proxyPass = "http://100.84.215.84:25500";
  	 };
  	#basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
      };
   };
}
