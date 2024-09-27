{ config, pkgs, lib, ... }:
{
imports =
    [
      ./base.nix 
      ./sound.nix
      ./video.nix 
      ./office.nix 

      ../packages/vim.nix
      ../packages/steam.nix
      
    ];

  environment.systemPackages = with pkgs; [
    openscad
    cura

    #libsForQt5.qt5ct
    #qt6Packages.qt6ct
    
    where-is-my-sddm-theme
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
  
  security.pam.services.swaylock = {};
  security.pam.services.swaylock-effects = {};

  services.displayManager = {
    enable = true;
    sessionPackages = with pkgs; [ sway ];
    sddm = {
      enable = true;
      theme = "${pkgs.where-is-my-sddm-theme}";
      wayland.enable = true;
      wayland.compositor = "kwin";
      autoNumlock = true;
      enableHidpi = true;
    };
  };

  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = true;

  #bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };

  };

  #automount
  services.udisks2.enable = true;

  #qt.platformTheme = "kde";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,no";
    variant = ",";
  };
  

}
