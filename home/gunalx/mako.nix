{ config, pkgs, ... }:

let
  palette = config.colorscheme.palette;
in {
  services.mako = {
    enable           = true;                        # Turn on mako
    package          = pkgs.mako;                   # Which package to use

    # Colors (from your colorscheme)
    settings.background-color  = "#${palette.base00}FF";       # popup background
    settings.text-color        = "#${palette.base05}FF";       # popup text
    settings.border-color      = "#${palette.base03}FF";       # popup border
    settings.progress-color    = "over #${palette.base0A}FF";  # progress bar

    # Placement & layering
    settings.anchor           = "top-right";                 # corner on screen
    settings.layer            = "overlay";                   # appear above fullscreen

    # Geometry
    settings.width            = 320;                         # px
    settings.height           = 120;                         # max px
    settings.margin           = "10";                        # all edges
    settings.padding          = "8";                         # all edges
    settings.border-size       = 2;                           # px
    settings.border-radius     = 12;                          # px

    # Font & icons
    settings.font             = "monospace 10";              # Pango font
    settings.icons            = true;                        # show icons
    settings.max-icon-size      = 48;                          # px

    # Behavior & timing
    settings.default-timeout   = 5000;                        # ms; 0 = no timeout
    settings.ignore-timeout    = true;                        # use defaultTimeout always
    settings.actions          = true;                        # clickable actions
    settings.max-visible       = 5;                           # simultaneous popups
    settings.sort             = "-time";                     # newest first
    settings.group-by          = "app-name";                  # grouping criteria
    settings.markup           = true;                        # enable Pango markup

    settings."actionable=true" = {
      default-timeout   = 15000; 
      border-radius     = 24; 
      border-color      = "#${palette.base08}FF";     
    };


  };
}
