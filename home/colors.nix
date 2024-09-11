{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
  ];


  # explanation https://github.com/chriskempson/base16/blob/main/styling.md
  colorScheme = {
    slug = "cyberpunk-apathy";
    name = "Cyberpunk Apathy";
    author = "Adrian G L (based on Apathy by Jannik Siebert)";
    palette = {
      base00 = "031A16"; # Background
      base01 = "0B342D"; # Lighter Background (Used for status bars, line number and folding marks)
      base02 = "184E45"; # Selection Background
      base03 = "2B685E"; # Comments, Invisibles, Line Highlighting
      base04 = "5F9C92"; # Dark Foreground (Used for status bars)
      base05 = "81B5AC"; # Default Foreground , Caret, Delimiters, Operators
      base06 = "A7CEC8"; # Light Foreground (Not often used)
      base07 = "D2E7E4"; # Light Background (Not often used)
      base08 = "3E9688"; # Variables , XML Tags, Markup Link Text, Markup Lists, Diff Deleted(Cyan)
      base09 = "3E7996"; # Integers , Boolean, Constants, XML Attributes, Markup Link Url(Blue)
      base0A = "4A3E96"; # Classes  Markup Bold, Search Text Background (Purple, slightly adjusted for cyberpunk feel)
      base0B = "883E96"; # Strings Inherited Class, Markup Code, Diff Inserted (Magenta)
      base0C = "963E4C"; # Support  Regular Expressions, Escape Characters, Markup Quotes (Red)
      base0D = "96883E"; # Functions Methods, Attribute IDs, Headings (Yellow)
      base0E = "4C963E"; # Keywords Storage, Selector, Markup Italic, Diff Changed (Green)
      base0F = "3E965B"; # Deprecate Opening/Closing Embedded Language Tags, e.g. <?php ?>d (Teal)
    };
  };

  programs.foot.settings.colors = {
    alpha = "0.95"; # Slightly more transparent for a cyberpunk feel
    foreground = "${config.colorScheme.palette.base05}";
    background = "${config.colorScheme.palette.base00}";
    regular0 = "${config.colorScheme.palette.base00}"; # Black
    regular1 = "${config.colorScheme.palette.base08}"; # Red
    regular2 = "${config.colorScheme.palette.base0B}"; # Green
    regular3 = "${config.colorScheme.palette.base0A}"; # Yellow
    regular4 = "${config.colorScheme.palette.base09}"; # Blue
    regular5 = "${config.colorScheme.palette.base0E}"; # Magenta
    regular6 = "${config.colorScheme.palette.base0C}"; # Cyan
    regular7 = "${config.colorScheme.palette.base05}"; # White
    bright0 = "${config.colorScheme.palette.base03}"; # Bright Black
    bright1 = "${config.colorScheme.palette.base08}"; # Bright Red
    bright2 = "${config.colorScheme.palette.base0B}"; # Bright Green
    bright3 = "${config.colorScheme.palette.base0A}"; # Bright Yellow
    bright4 = "${config.colorScheme.palette.base09}"; # Bright Blue
    bright5 = "${config.colorScheme.palette.base0E}"; # Bright Magenta
    bright6 = "${config.colorScheme.palette.base0C}"; # Bright Cyan
    bright7 = "${config.colorScheme.palette.base07}"; # Bright White
    # 16 = "${config.colorScheme.palette.base09}";
    # 17 = "${config.colorScheme.palette.base0F}";
    # 18 = "${config.colorScheme.palette.base01}";
    # 19 = "${config.colorScheme.palette.base02}";
    # 20 = "${config.colorScheme.palette.base04}";
    # 21 = "${config.colorScheme.palette.base06}";
  };
}
