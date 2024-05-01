{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
      nfs-utils
      cifs-utils
      jellyfin
      jellyfin-web
      jellyfin-mpv-shim
      jftui
      sonixd
      unpackerr
  ];
  users.groups.media.members = ["jellyfin"]; #have media directory owned by media group
  services.jellyfin.group = "media"; 
  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;

}
