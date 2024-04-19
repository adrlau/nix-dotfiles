{ config, pkgs, lib, ... }:
{
  #in all practicality equvivalent with elrond, but i migth get another puplic facing machine, so nice to have. (would need to move nginx routes to machine specific in that case)
imports =
    [ 
      ./base.nix
      ./sops.nix
      ../services/acme.nix
      ../services/nginx.nix
      ../services/fail2ban.nix
      #../services/authelia.nix
    ];


}
