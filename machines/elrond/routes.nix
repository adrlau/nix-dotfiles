{ config, pkgs, lib, ... }:
{
  services.nginx =  {
    virtualHosts."lauterer.it" = {
        forceSSL = true;
        useACMEHost = config.networking.domain;
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://100.84.215.84";
        };
    };  

    virtualHosts."managment.lauterer.it" = {
      forceSSL = true;
      useACMEHost = config.networking.domain;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://100.104.182.48";
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
    
    virtualHosts."film.lauterer.it" = {
      forceSSL = true;
      useACMEHost = config.networking.domain;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://100.104.182.48:8096";
      };
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
    
      virtualHosts."podgrab.lauterer.it" = {
        forceSSL = true;
        useACMEHost = config.networking.domain;
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://100.84.215.84:4242";
        };
        basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
      };

      virtualHosts."rss.lauterer.it" = {
        forceSSL = true;
        useACMEHost = config.networking.domain;
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://100.84.215.84:8081";
        };
        #basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
      };  

      virtualHosts."azul.256.no" = {
        forceSSL = true;
        useACMEHost = config.networking.domain;
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://100.84.215.84:8085";
        };
        #basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
      };  

 
    #virtualHosts."shiori.lauterer.it" = config.services.nginx.virtualHosts."archive.lauterer.it";
    #virtualHosts."pocket.lauterer.it" = config.services.nginx.virtualHosts."archive.lauterer.it";
    #virtualHosts."bookmarks.lauterer.it" = config.services.nginx.virtualHosts."archive.lauterer.it";
    virtualHosts."archive.lauterer.it" = {
        forceSSL = true;
        useACMEHost = config.networking.domain;
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://100.84.215.84:8082";
        };
        #basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
      };  



  };  
}
