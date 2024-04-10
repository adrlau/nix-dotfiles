{ config, pkgs, lib, ... }:
{


services.samba = {
  package = pkgs.samba4Full;
  enable = true;
  securityType = "user";
  openFirewall = true;
  extraConfig = ''
    workgroup = WORKGROUP
    server string = galadriel
    netbios name = galadriel
    security = user 
    #use sendfile = yes
    #max protocol = smb2
    min protocol = SMB3_00
    server smb encrypt = required
    # note: localhost is the ipv6 localhost ::1
    hosts allow = 192.168.1. 127.0.0.1 localhost 100.
    hosts deny = 0.0.0.0/0
    guest account = guest
    map to guest = bad user
  '';
  shares = {
   # public = {
   #   path = "/mnt/Shares/Public";
   #   browseable = "yes";
   #   "read only" = "no";
   #   "guest ok" = "yes";
   #   "create mask" = "0644";
   #   "directory mask" = "0755";
   #   "force user" = "username";
   #   "force group" = "groupname";
   # };
    Backup = {
      path = "/Main/Backup";
      "valid users" = "gunalx";
      "force user" = "gunalx";
      "force group" = "gunalx";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "yes";
      "create mask" = "0777";
      "directory mask" = "0777";
    };
  };
};

services.samba-wsdd = {
  enable = true;
  openFirewall = true;
};

#networking.firewall.enable = true;
networking.firewall.allowPing = true;





services.avahi.openfirewall = true;
services.avahi = {
    enable = true;
    nssmdns = true;
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
