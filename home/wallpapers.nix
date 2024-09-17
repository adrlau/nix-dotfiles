{ pkgs, ... }:

let
  wallpapers = pkgs.callPackage ./assets {};
in
{
  environment.systemPackages = [
    wallpapers
  ];

  home.packages = [
    wallpapers
  ];

  home.sessionVariables = {
    WALLPAPER_DIR = "${wallpapers}/share/wallpapers";
  };
}
