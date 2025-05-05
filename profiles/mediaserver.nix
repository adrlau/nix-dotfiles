{ config, pkgs, lib, ... }:
{
    imports =
        [ 
          ./base.nix
          #../services/podgrab.nix # not maintained
          ../services/jellyfin.nix
        ];
    
    environment.systemPackages = with pkgs.unstable; [
    ];



}
