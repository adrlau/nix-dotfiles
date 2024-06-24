{ config, pkgs, ... }:
{


  environment.systemPackages = with pkgs; [
     mariadb
     mysql-workbench
     jetbrains.datagrip
  ];

services.mysql = {
  enable = true;
  package = pkgs.mariadb;
   settings = {
     mysql = {
        local-infile = true;
        default-character-set="utf8mb4";
      };
      mysqld = {
        key_buffer_size = "6G";
        table_cache = 1600;
        log-error = "/var/log/mysql_err.log";
        plugin-load-add = [ "server_audit" "ed25519=auth_ed25519" ];
        collation-server = "utf8mb4_danish_ci";
        local_infile = 1;
        secure-file-priv = "";
        sql_mode = "IGNORE_SPACE,STRICT_ALL_TABLES,NO_ENGINE_SUBSTITUTION"; 
        init_connect = "SET NAMES 'utf8mb4' COLLATE 'utf8mb4_danish_ci'";

      };
      mysqldump = {
        quick = true;
        max_allowed_packet = "16M";
      };
    };


};

  


}
