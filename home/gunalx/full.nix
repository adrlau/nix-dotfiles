{ pkgs, lib, ... }:
{
  imports = [
    ./base.nix
    ./code.nix
    ./sway.nix
    ./niri.nix
    ../common/fonts.nix
    ./colors.nix

    #./stylix.nix

    #inputs.nix-colors.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    firefox
    gimp
    dconf
    feh
    ripgrep
    eza
    bottom
    killall
  ];
}

