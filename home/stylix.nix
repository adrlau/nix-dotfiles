{ pkgs, … }: 
 
{

  stylix.enable = true;

  
  stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  };


  stylix.base16Scheme = ”${pkgs.base16-schemes}/share/themes/apathy.yaml”;

 # stylix.fonts = {
 #   monospace = {
 #     package = pkgs.nerdfonts.override {fonts = [“JetBrainsMono”];};
 #     name = “JetBrainsMono Nerd Font Mono”;
 #   };
 #   sansSerif = {
 #     package = pkgs.dejavu_fonts;
 #     name = “DejaVu Sans”;
 #   };
 #   serif = {
 #     package = pkgs.dejavu_fonts;
 #     name = “DejaVu Serif”;
 #   };
 # };

 # stylix.fonts.sizes = {
 #   applications = 16;
 #   terminal = 12;
 #   desktop = 12;
 #   popups = 12;
 # };
 
  stylix.opacity = {
    applications = 1.0;
    terminal = 0.8;
    desktop = 1.0;
    popups = 1.0;
  };
  
  stylix.polarity = “dark” # “light” or “either”

}
