{ config, pkgs, lib, ... }:
{
imports =
    [
      ./base.nix 
      
    ];

  services.pipewire = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
        obs-studio
        obs-cli

        #obs-studio-plugins.obs-3d-effect
        obs-studio-plugins.wlrobs
        #obs-studio-plugins.obs-ndi
        #obs-studio-plugins.waveform
        #obs-studio-plugins.obs-vaapi
        #obs-studio-plugins.obs-teleport
        #obs-studio-plugins.obs-hyperion
        #obs-studio-plugins.droidcam-obs
        #obs-studio-plugins.input-overlay
        #obs-studio-plugins.obs-mute-filter
        #obs-studio-plugins.obs-source-clone
        #obs-studio-plugins.obs-source-record
        #obs-studio-plugins.obs-replay-source
        #obs-studio-plugins.obs-source-switcher
        obs-studio-plugins.obs-backgroundremoval
        obs-studio-plugins.obs-pipewire-audio-capture


        shotcut
        libsForQt5.kdenlive
        olive-editor
        subtitleedit
        

        vlc
        mpv


     ];

  programs.dconf.enable = true; #needed for easyeffects for some reason 


}
