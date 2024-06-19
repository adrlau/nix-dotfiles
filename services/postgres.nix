{ config, pkgs, ... }:
{


  environment.systemPackages = with pkgs; [
    postgresql
    pgadmin4
    pgadmin4-desktopmode
    pgmanage
    postgresql_16
  ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    ensureDatabases = [ "testing" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';

    extraPlugins = with pkgs.postgresql16Packages; [postgis pg_repack pgvector];

  };

  


}
