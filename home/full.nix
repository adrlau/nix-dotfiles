{ pkgs, lib, ... }:
{
  imports = [
    ./base.nix
    ./code.nix
    ./sway.nix
    #./stylix.nix

  ];
  home.packages = with pkgs; [
    firefox
    gimp
    dconf
  ];
}

