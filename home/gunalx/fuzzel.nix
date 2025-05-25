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
      font = "monospace:size=16";
      colors = {
        background = "${hex palette.base00}ff";
        foreground = "${hex palette.base05}ff";
        highlight  = "${hex palette.base0D}cc";
      };
      window = {
        border-radius = 12;
        x             = "center";
        y             = "15%";
      };
      icons = {
        size = 64;
      };
    };
  };
}
