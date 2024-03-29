{ config, pkgs, lib, ... }:
{
imports =
    [ 
      ./base.nix
      ./sops.nix
      ../services/nginx.nix
      #../services/authelia.nix
      #../services/fail2ban.nix
    ];

}
