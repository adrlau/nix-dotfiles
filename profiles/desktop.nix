{ unstable, config, pkgs, lib, ... } @ args: 
{
imports =
    [
      ./base.nix 
      ./sound.nix
      ./video.nix 
      ./office.nix
      ./development.nix

      ../packages/vim.nix
      ../packages/steam.nix

    ];

    environment.systemPackages = with pkgs; [
      libnotify
      openscad
      
      #cura # broken
      prusa-slicer

      #libsForQt5.qt5ct
      #qt6Packages.qt6ct
      where-is-my-sddm-theme      
      swww

      nvtopPackages.full
  ];

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    _0xproto

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    #nerdfonts
    ubuntu_font_family

  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);


  # Enable CUPS to print documents.
  services.printing.enable = false; #temp off because of CVE

  security.polkit.enable = true;
  
  security.pam.services.swaylock = {};
  security.pam.services.swaylock-effects = {};
  security.pam.services.ly = {};

#security.pam.services.display-manager.ly = {};
  services.displayManager = {
    enable = true;
    sessionPackages = with pkgs; [ sway niri];

    sddm = {
      enable = true;
      autoNumlock = true;
    };

  };

  services.power-profiles-daemon.enable = true;

  services.logind.powerKey = "ignore";

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
    layout = "no,us";
    variant = "";

  };
  

}
