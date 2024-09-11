{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
  ];
  colorScheme = {
    slug = "cyberpunk-apathy-adjusted";
    name = "Cyberpunk Apathy Adjusted";
    author = "Adrian G L (based on Apathy by Jannik Siebert)";
    palette = {
      base00 = "031A16"; # Background (kept original)
      base01 = "2A6D62"; # Lighter Background (brighter)
      base02 = "3D9F87"; # Selection Background (brighter)
      base03 = "68D6A0"; # Comments, Invisibles, Line Highlighting (brighter)
      base04 = "99E3D6"; # Dark Foreground (brighter)
      base05 = "D1F5E3"; # Default Foreground, Caret, Delimiters, Operators (brighter)
      base06 = "E0FCF8"; # Light Foreground (brighter)
      base07 = "FFFFFF"; # Light Background (brighter)
      base08 = "D066C2"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted (brighter teal)
      base09 = "6FBCDE"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url (brighter blue)
      base0A = "7E6BCC"; # Classes, Markup Bold, Search Text Background (brighter purple)
      base0B = "6ACB9A"; # Strings, Inherited Class, Markup Code, Diff Inserted (brighter magenta)
      base0C = "D26D6E"; # Support, Regular Expressions, Escape Characters, Markup Quotes (slightly adjusted red)
      base0D = "E0C964"; # Functions, Methods, Attribute IDs, Headings (brighter yellow)
      base0E = "8FCB5F"; # Keywords, Storage, Selector, Markup Italic, Diff Changed (brighter green)
      base0F = "6FC8B8"; # Deprecated, Opening/Closing Embedded Language Tags (brighter cyan)
    };
  };
  programs.foot.settings.colors = {
    alpha = "0.95"; # Slightly more transparent for a cyberpunk feel
    foreground = "${config.colorScheme.palette.base05}";
    background = "${config.colorScheme.palette.base00}";
    regular0 = "${config.colorScheme.palette.base00}"; # Black
    regular1 = "${config.colorScheme.palette.base08}"; # Red (now brighter teal)
    regular2 = "${config.colorScheme.palette.base0B}"; # Green
    regular3 = "${config.colorScheme.palette.base0A}"; # Yellow
    regular4 = "${config.colorScheme.palette.base09}"; # Blue
    regular5 = "${config.colorScheme.palette.base0E}"; # Magenta
    regular6 = "${config.colorScheme.palette.base0C}"; # Cyan (now slightly adjusted red)
    regular7 = "${config.colorScheme.palette.base05}"; # White
    bright0 = "${config.colorScheme.palette.base03}"; # Bright Black
    bright1 = "${config.colorScheme.palette.base08}"; # Bright Red (now brighter teal)
    bright2 = "${config.colorScheme.palette.base0B}"; # Bright Green
    bright3 = "${config.colorScheme.palette.base0A}"; # Bright Yellow
    bright4 = "${config.colorScheme.palette.base09}"; # Bright Blue
    bright5 = "${config.colorScheme.palette.base0E}"; # Bright Magenta
    bright6 = "${config.colorScheme.palette.base0C}"; # Bright Cyan (now adjusted red)
    bright7 = "${config.colorScheme.palette.base07}"; # Bright White
    selection-foreground = "${config.colorScheme.palette.base00}"; # Dark background color for selected text
    selection-background = "${config.colorScheme.palette.base0A}"; # Selection color
  };
}

