{ config, pkgs, lib, ... }:
let
  basicAuthUser = "guest";
  basicAuthPass = "12345678"; 
in
{

  #acme and certs helpful blog https://carjorvaz.com/posts/
  security.acme = {
    acceptTerms = true;
    defaults.email = "adrian+acme@lauterer.it";
    
    certs."${config.networking.domain}" = {
      domain = "${config.networking.domain}";
      extraDomainNames = [ "*.${config.networking.domain}"   "lauterer.it" "*.lauterer.it" "*.256.no" "*.256.no"];
      dnsProvider = "domeneshop";   # from here according to privider https://go-acme.github.io/lego/dns/ 
      dnsPropagationCheck = true;
      credentialsFile =  config.sops.secrets."acme/creds/domeneshop".path; #need to manually create this file according to dnsprovider secrets, and format of key according to lego in privider and add to secrets.yaml
    };
  };

  #add proxyserver to acme
  users.users.nginx.extraGroups = [ "acme" ];
  users.users.root.extraGroups = [ "acme" ];

  #TODO add oauth2 proxy to auth
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

    virtualHosts.${"vpn."+config.networking.domain} = {
      forceSSL = true;
      useACMEHost = "${config.networking.domain}";
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://localhost:${toString config.services.headscale.port}";
      };
    };

    virtualHosts.${config.services.kanidm.serverSettings.domain} = { # (auth.)
      forceSSL = true;
      useACMEHost = "${config.networking.domain}";
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "${"https://"+config.services.kanidm.serverSettings.bindaddress}";

      };
    };

    virtualHosts.${"jellyfin."+config.networking.domain} = {
      forceSSL = true;
      #enableACME = true;
      useACMEHost = "${config.networking.domain}";
      locations."/" = {
        proxyPass = "http://jellyfin.galadriel";
        proxyWebsockets = true;
        basicAuth = {
          guest = basicAuthPass;
        };
      };
    };
  };


}
