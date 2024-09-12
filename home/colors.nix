{ pkgs, config, nix-colors, ... }:

let
  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };

  background = "010C09";
  foreground = "FFFFFF";
  offWhite = "F0FFF8";
  teal = "60C89A";
  red = "E64553";
  blue = "58B5E0";
  green = "79E05B";
  purple = "6B5BDC";
  magenta = "80D1A0";
  cyan = "5FE2C5";
  yellow = "F5D24D";
  orange = "FF8800";
  pink = "FF4EC9";
  grey = "888B8E";
  lightGrey = "F3FCF7";
  darkTeal = "154E44";
  lighterTeal = "2C7A6A";
  lightTeal = "B0E8DA";

in{
  imports = [
    nix-colors.homeManagerModules.default
  ];

  #  colorScheme = nix-colors-lib.colorSchemeFromPicture {
  #    path = ./assets/evergarden-telescope.jpg;
  #    variant = "dark";
  #  };
  colorScheme = {
    slug = "cyberpunk-apathy";
    name = "Cyberpunk Apathy";
    author = "Adrian G L (based on Apathy by Jannik Siebert)";
    palette = {
      # Base16 color values with context-specific usage comments
      base00 = background;  # Default background
      base01 = darkTeal;    # Lighter background (used for status bars)
      base02 = lighterTeal; # Selection background
      base03 = teal;        # Comments, secondary content, line highlighting
      base04 = lightTeal;   # Darker foreground (used for status bars)
      base05 = foreground;  # Default text and foreground
      base06 = lightGrey;   # Lighter foreground (used for inactive text)
      base07 = offWhite;    # Lightest background (used for highlights)
      base08 = teal;        # Variables, constants, markup link text
      base09 = blue;        # Integers, booleans, constants, and XML attributes
      base0A = magenta;     # Classes, headings, keywords
      base0B = cyan;        # Strings, literals, escape sequences
      base0C = green;       # Support and error colors
      base0D = cyan;        # Functions, methods, function names
      base0E = red;         # Keywords, storage, selectors
      base0F = yellow;      # Deprecated or obsolete code
    };
  };

  programs.foot.settings.colors = {
    alpha = "0.85";
    #set based on https://github.com/tinted-theming/base16-foot/blob/main/colors/base16-apathy.ini   and https://github.com/tinted-theming/base16-schemes/blob/main/apathy.yaml

    foreground = "${config.colorScheme.palette.base05}";
    background = "${config.colorScheme.palette.base00}";

    regular0 = "${config.colorScheme.palette.base00}";  
    regular1 = "${config.colorScheme.palette.base08}";
    regular2 = "${config.colorScheme.palette.base0B}";
    regular3 = "${config.colorScheme.palette.base0A}";
    regular4 = "${config.colorScheme.palette.base0D}";
    regular5 = "${config.colorScheme.palette.base0E}";
    regular6 = "${config.colorScheme.palette.base0C}";
    regular7 = "${config.colorScheme.palette.base05}";
    
    bright0 = "${config.colorScheme.palette.base03}";
    bright1 = "${config.colorScheme.palette.base08}";
    bright2 = "${config.colorScheme.palette.base0B}";
    bright3 = "${config.colorScheme.palette.base0A}";
    bright4 = "${config.colorScheme.palette.base0D}";
    bright5 = "${config.colorScheme.palette.base0E}";
    bright6 = "${config.colorScheme.palette.base0C}";
    bright7 = "${config.colorScheme.palette.base07}";
    selection-foreground = "${config.colorScheme.palette.base00}";
    selection-background = "${config.colorScheme.palette.base0A}";
  };
}

