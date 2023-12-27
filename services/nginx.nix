{ config, pkgs, lib, ... }:
{  
  #declare secrets
  sops.secrets."acme/certs" = {  };
  sops.secrets."nginx/defaultpass" = {
    restartUnits = [ "nginx.service" ];
    owner = "nginx";
  };
  networking.domain = "addictedmaker.eu";
  #acme and certs helpful blog https://carjorvaz.com/posts/
  security.acme = {
    acceptTerms = true;
    defaults.email = "adrian+acme@lauterer.it";
    
    certs."${config.networking.domain}" = {
      domain = "${config.networking.domain}";
      extraDomainNames = [ 
        "*.${config.networking.domain}"
        #"${config.networking.domain}"
        #"lauterer.it"
        "*.lauterer.it"
        "*.256.no"
      ];
      dnsProvider = "domeneshop";   # from here according to provider https://go-acme.github.io/lego/dns/ 
      dnsPropagationCheck = true;
      #need to manually create this file according to dnsprovider secrets, and format of key according to lego in privider and add to secrets.yaml
      #credentialsFile =  config.sops.secrets."acme/certs".path; 
      credentialsFile =  "/run/secrets/acme/certs"; 
    };
  };

  #add proxyserver to acme
  users.users.nginx.extraGroups = [ "acme" ];
  users.users.root.extraGroups = [ "acme" ];

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
      #basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
    };

   # virtualHosts.${"vpn."+config.networking.domain} = {
   #   forceSSL = true;
   #   useACMEHost = "${config.networking.domain}";
   #   locations."/" = {
   #     proxyWebsockets = true;
   #     proxyPass = "http://localhost:${toString config.services.headscale.port}";
   #   };
   # };

   # virtualHosts.${config.services.kanidm.serverSettings.domain} = { # (auth.)
   #   forceSSL = true;
   #   useACMEHost = "${config.networking.domain}";
   #   locations."/" = {
   #     proxyWebsockets = true;
   #     proxyPass = "${"https://"+config.services.kanidm.serverSettings.bindaddress}";

   #   };
   # };

   # virtualHosts.${"jellyfin."+config.networking.domain} = {
   #   forceSSL = true;
   #   #enableACME = true;
   #   useACMEHost = "${config.networking.domain}";
   #   locations."/" = {
   #     proxyPass = "http://jellyfin.galadriel";
   #     proxyWebsockets = true;
   #     basicAuthFile = config.sops.secrets."nginx/defaultpass".path;
   #   };
   # };
  };


}
