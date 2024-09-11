{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  colorScheme = {
    slug = "neon-pulse";
    name = "Neon Pulse";
    author = "Adrian G L";
    palette = {
      base00 = "#1A1B2E"; # dark grey background
      base01 = "#2A2B3E"; # lighter background
      base02 = "#3A3B4E"; # selection background
      base03 = "#4A4B5E"; # comments, invisibles
      base04 = "#5A5B6E"; # dark foreground
      base05 = "#E4E3FE"; # default foreground (contrast)
      base06 = "#7A7B8E"; # light foreground
      base07 = "#8A8B9E"; # light background
      base08 = "#FF2A6D"; # variables, red
      base09 = "#9A9BAE"; # integers, constants
      base0A = "#05D9E8"; # classes, turquoise
      base0B = "#7DF9FF"; # strings, mint green
      base0C = "#13c299"; # support, cyan 
      base0D = "#24acd4"; # functions, methods, blue 
      base0E = "#A742EA"; # keywords, purple
      base0F = "#6B1FB1"; # deprecations, dark purple
    };
  };

  programs.foot.settings.colors = {
    alpha = "0.9";
    foreground = "${config.colorScheme.palette.base05}"; # Light foreground for high contrast
    background = "${config.colorScheme.palette.base00}"; # Dark background
    regular0 = "${config.colorScheme.palette.base00}"; # Black
    regular1 = "${config.colorScheme.palette.base08}"; # Red
    regular2 = "${config.colorScheme.palette.base0A}"; # Yellow (Turquoise)
    regular3 = "${config.colorScheme.palette.base0B}"; # Green
    regular4 = "${config.colorScheme.palette.base0D}"; # Blue (from foot default)
    regular5 = "${config.colorScheme.palette.base0E}"; # Magenta (Purple)
    regular6 = "${config.colorScheme.palette.base0C}"; # Cyan (from foot default)
    regular7 = "${config.colorScheme.palette.base05}"; # White
    bright0 = "${config.colorScheme.palette.base03}"; # Bright Black
    bright1 = "${config.colorScheme.palette.base08}"; # Bright Red 
    bright2 = "${config.colorScheme.palette.base0B}"; # Bright Green 
    bright3 = "e9e836"; # Bright Yellow (from foot default)
    bright4 = "5dc5f8"; # Bright Blue (from foot default)
    bright5 = "feabf2"; # Bright Magenta (from foot default)
    bright6 = "${config.colorScheme.palette.base0C}"; # Bright Cyan 
    bright7 = "${config.colorScheme.palette.base06}"; # Bright White 
  };
}
