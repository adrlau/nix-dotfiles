{ config, pkgs, lib, ... }:
{
#fail2ban
  services.fail2ban = {
    enable = true;
    maxretry = 10;

    #ignore local ips
    ignoreIP = [
      "127.0.0.0/8" 
      "10.0.0.0/8" 
      "100.64.0.0/8" 
      "172.16.0.0/12"
      "192.168.0.0/16"
      "8.8.8.8"
    ];
    jails = {
      nginx-http-auth = ''
        enabled  = true
        port     = http,https
        logpath  = /var/log/nginx/*.log
        backend  = polling
        journalmatch =
      '';
      nginx-botsearch = ''
        enabled  = true
        port     = http,https
        logpath  = /var/log/nginx/*.log
        backend  = polling
        journalmatch =
      '';
      nginx-bad-request = ''
        enabled  = true
        port     = http,https
        logpath  = /var/log/nginx/*.log
        backend  = polling
        journalmatch =
      '';
      authelia = ''
        enabled  = true
        port     = http,https
      '';
    };
  };



  environment.etc = {
      "fail2ban/filter.d/authelia.conf".text = ''
         # Fail2Ban filter for Authelia
   
         # Make sure that the HTTP header "X-Forwarded-For" received by Authelia's backend
         # only contains a single IP address (the one from the end-user), and not the proxy chain
         # (it is misleading: usually, this is the purpose of this header).
   
         # the failregex rule counts every failed 1FA attempt (first line, wrong username or password) and failed 2FA attempt
         # second line) as a failure.
         # the ignoreregex rule ignores debug, info and warning messages as all authentication failures are flagged as errors
   
         [Definition]
         failregex = ^.*Unsuccessful 1FA authentication attempt by user .*remote_ip="?<HOST>"? stack.*
                     ^.*Unsuccessful (TOTP|Duo|U2F) authentication attempt by user .*remote_ip="?<HOST>"? stack.*
   
         ignoreregex = ^.*level=debug.*
                       ^.*level=info.*
                       ^.*level=warning.*
   
        journalmatch = _SYSTEMD_UNIT=authelia-main.service + _COMM=authelia
      '';
    };
}
