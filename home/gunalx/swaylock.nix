{ pkgs, inputs, lib, config, nix-colors, ... }:
let
  palette = config.colorScheme.palette;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      # screen & indicator
      color                    = palette.base00;       # --color
      screenshots              = true;                 # --screenshots
      fade-in                  = 0.1;                  # --fade-in
      scaling                  = "fill";               # e.g. --scaling=fill

      # authentication grace
      grace                    = 15;                   # --grace
      submit-on-touch          = true;                 # --submit-on-touch

      # clock
      clock                    = true;                 # --clock

      # indicator visuals
      indicator-idle-visible   = true;                 # --indicator-idle-visible
      indicator-radius         = 100;                  # --indicator-radius
      indicator-thickness      = 7;                    # --indicator-thickness

      # indicator colors
      ring-color               = palette.base05;       # --ring-color
      key-hl-color             = palette.base03;       # --key-hl-color
      text-color               = palette.base00;       # --text-color
      inside-color             = palette.base04;       # --inside-color
      line-color               = palette.base00;       # --line-color
      separator-color          = palette.base00;       # --separator-color

      # effects
      effect-scale             = 0.6;                  # --effect-scale
      effect-blur              = "7x3";                # --effect-blur
    };
  };
}

