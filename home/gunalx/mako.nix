{ config, pkgs, ... }:

let
  palette = config.colorscheme.palette;
in {
  services.mako = {
    enable           = true;                        # Turn on mako
    package          = pkgs.mako;                   # Which package to use

    # Colors (from your colorscheme)
    backgroundColor  = "${palette.base00}FF";       # popup background
    textColor        = "${palette.base05}FF";       # popup text
    borderColor      = "${palette.base03}FF";       # popup border
    progressColor    = "over ${palette.base0A}FF";  # progress bar

    # Placement & layering
    anchor           = "top-right";                 # corner on screen
    layer            = "overlay";                   # appear above fullscreen

    # Geometry
    width            = 320;                         # px
    height           = 120;                         # max px
    margin           = "10";                        # all edges
    padding          = "8";                         # all edges
    borderSize       = 2;                           # px
    borderRadius     = 12;                          # px

    # Font & icons
    font             = "monospace 10";              # Pango font
    icons            = true;                        # show icons
    iconPath         = "/usr/share/icons:/usr/share/pixmaps";
    maxIconSize      = 48;                          # px

    # Behavior & timing
    defaultTimeout   = 3000;                        # ms; 0 = no timeout
    ignoreTimeout    = true;                        # use defaultTimeout always
    actions          = true;                        # clickable actions
    maxVisible       = 5;                           # simultaneous popups
    sort             = "-time";                     # newest first
    groupBy          = "app-name";                  # grouping criteria
    markup           = true;                        # enable Pango markup

  };
}
