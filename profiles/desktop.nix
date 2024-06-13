{ config, pkgs, lib, ... }:
{
imports =
    [
      ./base.nix 
      ./sound.nix #all i would ever need in sound.
      ./video.nix #all i would ever need in sound.
      ./office.nix #all i would ever need in sound.

      ../packages/vim.nix
      #../home/home-full.nix
      #./sway.nix
      ../packages/steam.nix
      
    ];

  environment.systemPackages = with pkgs; [
    openscad
    cura

    libsForQt5.qt5ct
    qt6Packages.qt6ct
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerdfonts
    ubuntu_font_family

  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.polkit.enable = true;
  

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = true;

  qt.platformTheme = "qt5ct";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };


  #TODO: add sway with home manager to get proper dotfiles. Possibly in its own sway file.
  #TODO: add hyperland.

  

}
