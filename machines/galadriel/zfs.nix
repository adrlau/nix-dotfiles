{ config, pkgs, lib, ... }:
{  
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "1ccccd3a";
  services.zfs.trim.enable = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoSnapshot.flags = "-k -p --utc";

  environment.packages = with pkgs; [
    zfs
    zfsnap
    zfstools
    zfsbackup
    lz4
  ];

}
