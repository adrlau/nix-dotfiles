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
        use-bold = true;
        fields = "filename,name,keywords,exec,comment,generic";
        tabs = "4";

        width = 60; # Wider window (characters)
        lines = 20; # Show more items vertically
        horizontal-pad = 50; # Horizontal padding
        vertical-pad = 15; # Vertical padding

        font = "monospace:size=16"; 

        anchor = "top";
        y-margin = 240;
        icons-enabled = true;            
        # match-mode = "fzf"; 
        # image-size-ratio = 0.5; 
      };
      colors = {
        background = "${hex palette.base00}ff";
        text = "${hex palette.base03}ff";
        prompt = "${hex palette.base03}ff";
        placeholder = "${hex palette.base03}ff";
        input = "${hex palette.base05}ff";
        match = "${hex palette.base08}ff";
        selection = "${hex palette.base02}ff";
        "selection-text" = "${hex palette.base05}ff";
        "selection-match" = "${hex palette.base08}ff";
        counter = "${hex palette.base04}ff";
        border = "${hex palette.base03}ff";
      };
      border = {
        radius = 20; 
        width = 3; 
      };
    };
  };
}
