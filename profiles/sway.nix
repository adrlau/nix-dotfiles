{ config, pkgs, lib, ... }:
{
imports =
    [
      
    ];

  environment.systemPackages = with pkgs; [
    	libsForQt5.qt5ct
    	qt6Packages.qt6ct
	
	waybar
	networkmanagerapplet
	networkmanager
	libsForQt5.networkmanager-qt
	
	wdisplays

	swaylock-effects
	#swaylock-fancy #migth change to this default may look prettier.
	
	foot
	## possible other options
	#kitty
	#alacrity
	
	wofi
	wofi-emoji
	bemoji
	
	brightnessctl

	pavucontrol
	
	#screenshots	
	grim
	slurp

	swaybg

	workstyle
	#swayest-workstyle #migth switch to this.
	autotiling-rs
	wleave	
	
	pass-wayland

  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
    nerdfonts
    ubuntu_font_family
    zpix-pixel-font

    font-awesome
    font-awesome_5
    font-awesome_4

  ];


  qt.platformTheme = "qt5ct";
  

}
