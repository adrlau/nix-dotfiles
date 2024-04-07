{ config, pkgs, lib, ... }:
{


services.samba = {
  enable = true;
  securityType = "user";
  openFirewall = true;
  extraConfig = ''
    workgroup = WORKGROUP
    server string = smbnix
    netbios name = smbnix
    security = user 
    #use sendfile = yes
    #max protocol = smb2
    # note: localhost is the ipv6 localhost ::1
    hosts allow = 192.168.0. 127.0.0.1 localhost 100.0.0.0/8
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
    Main = {
      path = "/Main";
      "valid users" = "gunalx";
      "force user" = "gunalx";
      "force group" = "gunalx";

      public = "no";
      browseable = "yes";
      writeable = "yes";
      
      "fruit:aapl" = "yes";
      "fruit:time machine" = "yes";
      "vfs objects" = "catia fruit streams_xattr";

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
