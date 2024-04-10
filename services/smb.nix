{ config, pkgs, lib, ... }:
{


services.samba = {
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
    # note: localhost is the ipv6 localhost ::1
    hosts allow = 192.168.1. 127.0.0.1 localhost 100.
    hosts deny = 0.0.0.0/0
    guest account = nobody
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
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
    };
  };
};

services.samba-wsdd = {
  enable = true;
  openFirewall = true;
};

#networking.firewall.enable = true;
networking.firewall.allowPing = true;


}
