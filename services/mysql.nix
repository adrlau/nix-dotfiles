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
};

  


}
