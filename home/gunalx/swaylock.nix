{ pkgs, inputs, lib, config, nix-colors, ... }:
let
  palette = config.colorScheme.palette;
in
{
  imports = [
  ];

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      color = palette.base00;
      screenshots = true;
      grace = 15;
      clock = true;
      submit-on-touch = true;
      indicator-idle-visible = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      ring-color = palette.base05;
      key-hl-color = palette.base03;
      tect-color = palette.base00;
      line-colot = palette.base00;
      innside-color = palette.base04;
      seperator-color = palette.base00;
      fade-in = 0.1;
      effect-scale = 0.6;
      effect-blur = "7x3";
    };
  };


}

