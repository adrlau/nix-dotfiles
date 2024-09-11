{ pkgs, lib, ... }:
{
  imports = [
    ./base.nix
    ./code.nix
    ./sway.nix
    ./colors.nix

    #inputs.nix-colors.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    firefox
    gimp
    dconf
  ];
}

