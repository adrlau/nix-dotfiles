{ config, pkgs, lib, ... }:
{  
  #declare secrets
  sops.secrets."acme/certs" = {  };

  networking.enableIPv6 = false; #For some reason acme only works without ipv6, probably because of missing AAAA records. 
  networking.domain = "lauterer.it";
  #acme and certs helpful blog https://carjorvaz.com/posts/
  security.acme = {
    acceptTerms = true;
    defaults.email = "adrian+acme@lauterer.it";
    certs."${config.networking.domain}" = {
      domain = "${config.networking.domain}";
      extraDomainNames = [ 
        "*.${config.networking.domain}"
        #"lb0fj.eu"
        #"*.lb0fj.eu"
        "256.no"
        "*.256.no"
        "*.addictedmaker.eu"
        "addictedmaker.eu"
      ];
      
      ## for testing.
      #server = "https://acme-staging-v02.api.letsencrypt.org/directory"; 
      #enableDebugLogs = true;

      #legos registrar specific stuff. 
      dnsResolver = "ns1.hyp.net:53";
      dnsProvider = "domeneshop";   # from here according to provider https://go-acme.github.io/lego/dns/ 
      dnsPropagationCheck = true;
      #need to manually create this file according to dnsprovider secrets, and format of key according to lego in privider and add to secrets.yaml
      credentialsFile =  config.sops.secrets."acme/certs".path; 
    };
  };

  #add proxyserver to acme group
  users.users.nginx.extraGroups = [ "acme" ];
  users.users.root.extraGroups = [ "acme" ];
}
