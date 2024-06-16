{ pkgs, lib, ... }:
{
  imports = [
    ./base.nix
    ./code.nix
    ./sway.nix

  ];
  home.packages = with pkgs; [
    firefox
    gimp
  ];
}

