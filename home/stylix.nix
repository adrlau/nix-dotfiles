{ pkgs, lib, ... }: 
{

  stylix.enable = true;
  
  stylix.image = ./assets/wallpaper.jpg; 

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/apathy.yaml";

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override {fonts = [“JetBrainsMono”];};
      name = “JetBrainsMono Nerd Font Mono”;
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = “DejaVu Sans”;
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = “DejaVu Serif”;
    };
  };

  stylix.fonts.sizes = {
    applications = 16;
    terminal = 12;
    desktop = 12;
    popups = 12;
  };
 
  stylix.opacity = {
    applications = 0.9;
    terminal = 0.7;
    desktop = 0.9;
    popups = 0.9;
  };
  
  stylix.polarity = "dark"; # “light” or “either”

}

