{ config, pkgs, lib, ... }:
{
imports =
    [
      ./base.nix 
      
    ];


  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };


  environment.systemPackages = with pkgs; [
    pavucontrol
    wireplumber
    easyeffects
    ncpamixer
    qpaeq
    #more audio stuff, but not essential
    
    #synths
    qsynth
    fluidsynth
    synthesia
    vital
    picoloop
    #bespokesynth-with-vst2 #always takes ages compiling
    #fmsynth
    polyphone #soundfont editor

    #vocaloids
    openutau
    #daw
    ardour
    lmms
    rosegarden
    musescore

    #playing audio
    cmus
    cmusfm
    whistle
    cozy
    lollypop
    libsForQt5.elisa

    shortwave
    radioboat
    gqrx

    headset
    nuclear
    spotifyd
    spotify-player
    spotify
    spotify-tray

    tenacity

    libsForQt5.soundkonverter
  ];

  programs.dconf.enable = true; #needed for easyeffects for some reason 

}
