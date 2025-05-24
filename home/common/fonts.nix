{ pkgs, lib, ... }:
{
  
  home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        ubuntu_font_family
        zpix-pixel-font
        font-awesome
        font-awesome_5
        font-awesome_4

    ]++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues nerd-fonts);


  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
      emoji = ["noto-fonts-emoji font-awesome"];
      monospace = ["zpix" "fira-code"];
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
  };

 

}

