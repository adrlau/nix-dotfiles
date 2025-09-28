{ config, pkgs, lib, ... }:
{
#  environment.systemPackages = [
#    pkgs.sendmail
#  ];

    sops.secrets."vaultwarden/environmentFile" = {
      restartUnits = [ "vaultwarden.service" ];
      owner = "vaultwarden";
      mode = "0755";
    };





    services.vaultwarden = {
        enable = true;
        environmentFile = config.sops.secrets."vaultwarden/environmentFile".path;
        dbBackend = "sqlite";
        backupDir = "/var/backup/vaultwarden";
    };

}
