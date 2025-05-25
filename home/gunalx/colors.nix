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
    slug = "teal-green-dark";
    name = "Teal Green Dark";
    author = "Auto‐generated";
    palette = {
      # Base16 Teal‐Green Dark Theme
      base00 = "0f1f1c"; # Default background
      base01 = "143028"; # Lighter background (status bars)
      base02 = "1e3b34"; # Selection background
      base03 = "28514b"; # Comments, secondary content
      base04 = "4a7b70"; # Dark foreground (status bars)
      base05 = "d4efe0"; # Default foreground
      base06 = "e4f8f2"; # Light foreground
      base07 = "fafdfb"; # Lightest background
      base08 = "63d1be"; # Variables, markup link text
      base09 = "3dc28f"; # Integers, constants
      base0A = "a2e096"; # Classes, search highlight
      base0B = "8ce45a"; # Strings, inserted
      base0C = "4cd7e5"; # Support, escape characters
      base0D = "2e97d5"; # Functions, headings
      base0E = "df6fad"; # Keywords, selectors
      base0F = "e5d97f"; # Deprecated tags
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

