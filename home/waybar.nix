{ pkgs, inputs, lib, config, nix-colors, ... }:

{
  imports = [
  ];



  programs.waybar = let
        inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
        inherit (config.colorscheme) colors;
        inherit (config.colorscheme) palette;
        toRGBA = color: opacity: "rgba(${hexToRGBString "," (lib.removePrefix "#" color)},${opacity})";
      in {

    enable = true;



    style = ''
* {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    font-size: 13px;
}

window#waybar {
    background-color: #${palette.base00};
    border-bottom: 3px solid #${palette.base03};
    color: ${toRGBA palette.base05 "0.7"};
    transition-property: background-color;
    transition-duration: .5s;
}

window#waybar.hidden {
    opacity: 0.2;
}

/*
window#waybar.empty {
    background-color: transparent;
}
window#waybar.solo {
    background-color: #${palette.base07};
}
*/

window#waybar.termite {
    background-color: #${palette.base03};
}

window#waybar.chromium {
    background-color: #${palette.base00};
    border: none;
}

button {
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
    /* Avoid rounded borders under each button name */
    border: none;
    border-radius: 0;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
    background: inherit;
    box-shadow: inset 0 -3px #${palette.base05};
}

/* you can set a style on hover for any module like this */
#pulseaudio:hover {
    background-color: #${palette.base0A};
}

#workspaces button {
    padding: 0 5px;
    background-color: transparent;
    color: #${palette.base05};
}

#workspaces button:hover {
    background: #${palette.base00};
}

#workspaces button.focused {
    background-color: #${palette.base03};
    box-shadow: inset 0 -3px #${palette.base05};
}

#workspaces button.urgent {
    background-color: #${palette.base08};
}

#mode {
    background-color: #${palette.base03};
    box-shadow: inset 0 -3px #${palette.base05};
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#power-profiles-daemon,
#mpd {
    padding: 0 10px;
    color: #${palette.base05};
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    background-color: #${palette.base03};
}

#battery {
    background-color: #${palette.base05};
    color: #${palette.base00};
}

#battery.charging, #battery.plugged {
    color: #${palette.base05};
    background-color: #${palette.base0B};
}

@keyframes blink {
    to {
        background-color: #${palette.base05};
        color: #${palette.base00};
    }
}

/* Using steps() instead of linear as a timing function to limit cpu usage */
#battery.critical:not(.charging) {
    background-color: #${palette.base08};
    color: #${palette.base05};
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: steps(12);
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#power-profiles-daemon {
    padding-right: 15px;
}

/*0b also looked good though.  */
#power-profiles-daemon.performance {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#power-profiles-daemon.balanced {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#power-profiles-daemon.power-saver {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

label:focus {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#cpu {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#memory {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#disk {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#backlight {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#network {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#network.disconnected {
    background-color: #${palette.base0E};
    color: #${palette.base00};
}

#pulseaudio {
    background-color: #${palette.base0A};
    color: #${palette.base00};
}

#pulseaudio.muted {
    background-color: #${palette.base0E};
    color: #${palette.base03};
}

#wireplumber {
    background-color: #${palette.base07};
    color: #${palette.base00};
}

#wireplumber.muted {
    background-color: #${palette.base0E};
    color: #${palette.base00};
}

#custom-media {
    background-color: #${palette.base04};
    color: #${palette.base00};
    min-width: 100px;
}

#custom-media.custom-spotify {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#custom-media.custom-vlc {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#temperature {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#temperature.critical {
    background-color: #${palette.base0E};
    color: #${palette.base00};
}

#tray {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: #${palette.base07};
    color: #${palette.base00};
}

#idle_inhibitor {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#idle_inhibitor.activated {
    background-color: #${palette.base06};
    color: #${palette.base00};
}

#mpd {
    background-color: #${palette.base04};
    color: #${palette.base00};
}

#mpd.disconnected {
    background-color: #${palette.base06};
    color: #${palette.base00};
}

#mpd.stopped {
    background-color: #${palette.base0C};
}

#mpd.paused {
    background-color: #${palette.base0B};
}

#language {
    background: #${palette.base04};
    color: #${palette.base00};
    padding: 0 5px;
    margin: 0 5px;
    min-width: 16px;
}

#keyboard-state {
    background: #${palette.base04};
    color: #${palette.base00};
    padding: 0 0px;
    margin: 0 5px;
    min-width: 16px;
}

#keyboard-state > label {
    padding: 0 5px;
}

#keyboard-state > label.locked {
    background: #${palette.base04};
    color: #${palette.base00};
}

#scratchpad {
    background: #${palette.base00};
    color: #${palette.base00};
}

#scratchpad.empty {
    background-color: transparent;
}

#privacy {
    padding: 0;
    color: #${palette.base04};
}

#privacy-item {
    color: #${palette.base00};
    padding: 0 5px;
}

#privacy-item.screenshare {
    background-color: #${palette.base00};
}

#privacy-item.audio-in {
    background-color: #${palette.base0B};
}

#privacy-item.audio-out {
    background-color: #${palette.base0D};
}

      '';

  };




}

