{ pkgs, lib, ... }:
{
  
    home.packages = with pkgs; [
        nerdfonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        nerdfonts
        ubuntu_font_family
        zpix-pixel-font
        _0xproto
        font-awesome
        font-awesome_5
        font-awesome_4

    ];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
      emoji = ["noto-fonts-emoji font-awesome"];
      monospace = ["0xproto" "zpix" "fira-code"];
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
  };

 

}

