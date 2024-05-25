{ config, lib, pkgs, ... }: let


wordpress-theme = pkgs.stdenv.mkDerivation rec {
  name = "responsive";
  version = "4.7.9";
  src = pkgs.fetchzip {
    url = "https://downloads.wordpress.org/theme/responsive.${version}.zip";
    hash = "sha256-7K/pwD1KAuipeOAOLXd2wqOUEhwk+uNGIllVWzDHzp0=";
  };
  installPhase = "mkdir -p $out; cp -R * $out/";
};

in {
  services.wordpress.sites."lauterer.it" = {
    languages = [ 
      pkgs.wordpressPackages.languages.de_DE
    ];
    settings = {
      WPLANG = "de_DE";
      #FORCE_SSL_ADMIN = true;
    };
    extraConfig = ''
    $_SERVER['HTTPS']='on';
  '';
    #themes = {
    #  inherit wordpress-theme;
    #};
    plugins = with pkgs.wordpressPackages.plugins; [
        #anti-spam-bee
        code-syntax-block
        cookie-notice
        wp-gdpr-compliance
      ];
    
  };
}

