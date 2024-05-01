{ config, pkgs, lib, ... }:
{
    imports =
        [ 
          ./base.nix
          ../services/podgrab.nix
          ../services/jellyfin.nix
        ];
    
    environment.systemPackages = with pkgs.unstable; [
    ];



}
