{ pkgs, lib, ... }:
{
  
  home.packages = with pkgs; [
        nerd-fonts._0xproto
        _0xproto
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        noto-fonts-color-emoji
        noto-fonts-emoji-blob-bin
        unicode-emoji

        liberation_ttf
        fira-code
        fira-code-symbols
        ubuntu_font_family
        zpix-pixel-font
        font-awesome
        font-awesome_5
        font-awesome_4
        nerd-fonts._0xproto

    ]++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);


  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
      emoji = ["noto-fonts-emoji font-awesome"];
      monospace = ["0xproto" "zpix" "fira-code"];
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
  };

 

}

