{ pkgs
, lib
, inputs
, config
, nix-colors
, ...
}:

let
  # Grab your palette and the hex→RGBA helper
  palette   = config.colorscheme.palette;
  toRGBA    = color: alpha:
    let rgb = nix-colors.lib.conversions.hexToRGBString "," (lib.removePrefix "#" color);
    in "rgba(${rgb},${alpha})";

  # Path to the wleave-provided icons
  iconsDir  = "${pkgs.wleave}/share/wleave/icons";
in

{
  programs.wlogout = {
    enable  = true;
    package = pkgs.wlogout;

    # Your button layout
    layout = [
      { label = "lock";      action = "swaylock";                       text = "Lock";      keybind = "l"; }
      { label = "hibernate"; action = "systemctl hibernate";           text = "Hibernate"; keybind = "h"; }
      { label = "logout";    action = "loginctl terminate-user $USER"; text = "Logout";    keybind = "e"; }
      { label = "shutdown";  action = "systemctl poweroff";             text = "Shutdown";  keybind = "s"; }
      { label = "suspend";   action = "systemctl suspend";              text = "Suspend";   keybind = "u"; }
      { label = "reboot";    action = "systemctl reboot";               text = "Reboot";    keybind = "r"; }
    ];

    style = ''
      * { background-image: none; }

      window {
        background-color: ${toRGBA palette.base00 "0.7"};
      }

      button {
        color:            #${palette.base0C};
        background-color: ${toRGBA palette.base02 "0.8"};
        border:           2px solid #${palette.base0C};
        border-radius:    1em;
        margin:           0.75em;
        background-repeat: no-repeat;
        background-position: center;
        box-shadow:       0 0 4px #${palette.base0C};
        padding:          0.6em 1.2em;
      }

      button:focus,
      button:active {
        background-color: ${toRGBA palette.base03 "0.9"};
        box-shadow:       0 0 6px #${palette.base0C};
        outline:          none;
      }

      #lock      { background-image: image(url("${iconsDir}/lock.svg")); }
      #logout    { background-image: image(url("${iconsDir}/logout.svg")); }
      #suspend   { background-image: image(url("${iconsDir}/suspend.svg")); }
      #hibernate { background-image: image(url("${iconsDir}/hibernate.svg")); }
      #shutdown  { background-image: image(url("${iconsDir}/shutdown.svg")); }
      #reboot    { background-image: image(url("${iconsDir}/reboot.svg")); }
    '';
  };
}
