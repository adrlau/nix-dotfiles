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
    
      virtualHosts."podgrab.lauterer.it" = {
        forceSSL = true;
        useACMEHost = config.networking.domain;
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://100.84.215.84:4242";
        };
        basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
      };

      virtualHosts."freshrss.lauterer.it" = {
        forceSSL = true;
        useACMEHost = config.networking.domain;
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://100.84.215.84:80";
        };
        basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
      };  
      
      virtualHosts."minecraft.256.no" = {
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "100.84.215.84:25565";
          extraConfig = ''
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
              '';
        };
      };


   };
}
