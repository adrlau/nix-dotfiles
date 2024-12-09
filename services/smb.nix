{ config, pkgs, lib, ... }:
{


services.samba = {
  package = pkgs.samba4Full;
  enable = true;
  securityType = "user";
  openFirewall = true;
};

services.samba-wsdd = {
  enable = true;
  openFirewall = true;
};

networking.firewall.allowPing = true;

services.avahi.openfirewall = true;
services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };




}
