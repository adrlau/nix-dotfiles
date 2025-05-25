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



  gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  # Ensure the Adwaita GTK theme is installed so wlogout can load gtk.css
  home.packages = with pkgs; [
    gnome-themes-extra
  ];

}

