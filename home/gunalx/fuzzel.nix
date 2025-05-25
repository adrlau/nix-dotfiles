{ config, pkgs, lib, inputs, ... }:

let
  palette = config.colorScheme.palette;
  hex = colour: lib.removePrefix "#" colour;
in

{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
    settings = {
      main = {
        terminal = "${pkgs.foot}/bin/foot";
        layer    = "overlay";
      };
      colors = {
        background = "${hex palette.base00}ff";
        foreground = "${hex palette.base05}ff";
        highlight  = "${hex palette.base0D}ff";
      };
    };
  };
}
