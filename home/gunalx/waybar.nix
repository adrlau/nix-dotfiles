{ config, pkgs, lib, inputs, ... }:

let
  # Import Base16 palette & hex→RGB helper
  inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
  inherit (config.colorscheme) palette;

  # Build "rgba(r,g,b,a)" strings
  toRGBA = colour: alpha:
    let rgb = hexToRGBString "," (lib.removePrefix "#" colour);
    in "rgba(${rgb},${alpha})";
in
{
  programs.waybar = {
    enable = true;

    # Single-bar JSON config
    settings = [
      (builtins.fromJSON ''
        {
          "height": 36,
          "spacing": 2,
          "modules-left": [ "custom/launcher", "sway/workspaces","niri/workspaces"],
          "modules-center": ["niri/window"],
          "modules-right": [
            "idle_inhibitor","backlight","pulseaudio","keyboard-state",
            "network","cpu","memory","temperature","battery",
            "power-profiles-daemon","clock","tray","custom/power"
          ],

          "custom/launcher": {
            "format": "  ",
            "on-click": "pkill fuzzel || fuzzel"
          },

          "sway/workspaces": {
            "format": "{index}: {name} - {icon}",
            "format-icons": {
              "focused":"","active":"","default":""
            },
            "all-outputs": false,
            "current-only": false,
            "persistent": true,
            "on-click": "swaymsg workspace number {index}"
          },

          "niri/workspaces": {
            "format": "{index}: {name} - {icon}",
            "format-icons": {
              "focused":"","active":"","default":""
            },
            "all-outputs": false,
            "current-only": false,
            "persistent": true,
            "on-click": "niri msg workspace {index}"
          },

          "niri/window": {
            "format": "{title}"
          },

          "idle_inhibitor": {
            "format": "{icon}",
            "format-icons": { "activated":"","deactivated":"" }
          },

          "backlight": {
            "format": "{percent}% {icon}",
            "format-icons": ["","","","","","","","",""]
          },

          "pulseaudio": {
            "format": "{volume}% {icon}",
            "format-muted": "",
            "format-icons": { "default": ["","",""] },
            "on-click": "pavucontrol"
          },

          "keyboard-state": {
            "numlock": true,
            "capslock": true,
            "format": "{icon}",            
            "format-icons": { "locked":"","unlocked":"" }
          },

          "network": {
            "format-wifi": " {essid} ({signalStrength}%)",
            "format-ethernet": " {ipaddr}",
            "format-disconnected": "⚠ Disconnected",
            "format-alt": " {ipaddr}/{cidr}",
            "format-alt-click": "click",
            "tooltip": true,
            "tooltip-format-wifi": "<span color='#${palette.base0C}'></span> <span color='#${palette.base05}'>WiFi</span>\n<span color='#${palette.base0A}'>SSID:</span> <span color='#${palette.base06}'>{essid}</span>\n<span color='#${palette.base0A}'>Interface:</span> <span color='#${palette.base04}'>{ifname}</span>\n<span color='#${palette.base0A}'>IP:</span> <span color='#${palette.base06}'>{ipaddr}</span>\n<span color='#${palette.base0A}'>IPv6:</span> <span color='#${palette.base04}'>{ipaddr6}</span>\n<span color='#${palette.base0A}'>Gateway:</span> <span color='#${palette.base04}'>{gwaddr}</span>\n<span color='#${palette.base0A}'>Frequency:</span> <span color='#${palette.base04}'>{frequency} MHz</span>\n<span color='#${palette.base0A}'>Signal:</span> <span color='#${palette.base0B}'>{signalStrength}%</span> <span color='#${palette.base04}'>({signaldBm} dBm)</span>",

"tooltip-format-ethernet": "<span color='#${palette.base0C}'></span> <span color='#${palette.base05}'>Ethernet</span>\n<span color='#${palette.base0A}'>Interface:</span> <span color='#${palette.base04}'>{ifname}</span>\n<span color='#${palette.base0A}'>IP:</span> <span color='#${palette.base06}'>{ipaddr}</span>\n<span color='#${palette.base0A}'>IPv6:</span> <span color='#${palette.base04}'>{ipaddr6}</span>\n<span color='#${palette.base0A}'>Gateway:</span> <span color='#${palette.base04}'>{gwaddr}</span>\n<span color='#${palette.base0A}'>Netmask:</span> <span color='#${palette.base04}'>{netmask}</span>",

        "tooltip-format-disconnected": "<span color='#${palette.base08}'>⚠</span> <span color='#${palette.base08}'>No Connection</span>\n<span color='#${palette.base04}'>Click to refresh network info</span>",

            "on-click": "nmcli device wifi rescan && nmcli connection show --active",
            "on-click-right": "nmcli device status",
            "max-length": 50
          },

          "cpu":    { "format": " {usage}%" },
          "memory": { "format": " {used:0.1f}G" },

          "temperature": {
            "format": "{temperatureC}°C ",
            "critical-threshold": 80
          },

          "battery": {
            "format": "{capacity}% {icon}",
            "format-icons": ["","","","",""],
            "format-charging": "{capacity}% ",
            "states": { "warning": 30, "critical": 15 }
          },

          "power-profiles-daemon": {
            "format": "{icon}",
            "format-icons": {
              "performance":"","balanced":"","power-saver":""
            },
            "on-click": "systemctl --user power-profiles-daemon set balanced"
          },

          "power-profiles-daemon": {
            "format": "{icon}",
            "tooltip-format": "Power profile: {profile}nDriver: {driver}",
            "tooltip": true,
            "format-icons": {
              "default": "",
              "performance": "",
              "balanced": "",
              "power-saver": ""
            }
          },

          "clock": {
            "format": "{:%H:%M}",
            "format-alt": "{:%Y-%m-%d}",
            "tooltip": true,
            "tooltip-format": "<tt><small>{calendar}</small></tt>",
            "calendar": {
              "mode": "month",
              "mode-mon-col": 3,
              "weeks-pos": "right",
              "on-scroll": 1,
              "format": {
                "months": "<span color='#${palette.base05}'><b>{}</b></span>",
                "days": "<span color='#${palette.base04}'>{}</span>",
                "weeks": "<span color='#${palette.base0C}'><b>W{}</b></span>",
                "weekdays": "<span color='#${palette.base0A}'><b>{}</b></span>",
                "today": "<span color='#${palette.base08}'><b><u>{}</u></b></span>"
              }
            },
            "actions": {
              "on-click-right": "mode",
              "on-scroll-up": "shift_up",
              "on-scroll-down": "shift_down"
            }
          },

          "tray": {
            "spacing": 8
          },

          "custom/power": {
            "format": "⏻",
            "tooltip": "exit",
            "on-click": "wleave"
          }
        }
      '')
    ];

    # CSS style for Waybar
    style = ''
      /* Base font */
      * { font-family: FontAwesome, Roboto, sans-serif; font-size: 13px; }

      /* Bar container */
      window#waybar {
        background-color: ${toRGBA palette.base00 "0.5"};
        border-radius: 12px;
        padding: 4px 20px;
        border: none;
      }

      /* Workspace margin */
      #sway-workspaces,#niri-workspaces { margin-left: 12px; }

      /* Module blocks */
      #idle_inhibitor,#backlight,#pulseaudio,#keyboard-state,
      #network,#cpu,#memory,#temperature,#battery,
      #power-profiles-daemon,#clock,#tray,#custom-power,#custom-launcher,#niri-window {
        background-color: ${toRGBA palette.base01 "0.4"};
        border-radius: 8px;
        margin: 0 6px;
        padding: 0 10px;
        border: 1px solid ${toRGBA palette.base07 "0.6"};
      }

      /* Hover effect */
      #idle_inhibitor:hover,#backlight:hover,#pulseaudio:hover,
      #keyboard-state:hover,#network:hover,#cpu:hover,#memory:hover,
      #temperature:hover,#battery:hover,#power-profiles-daemon:hover,
      #clock:hover,#tray:hover,#custom-power:hover,#custom-launcher:hover,#niri-window:hover {
        background-color: ${toRGBA palette.base02 "0.5"};
      }

      /* Tooltip styling */
      tooltip {
        background-color: ${toRGBA palette.base00 "0.9"};
        border: 1px solid ${toRGBA palette.base07 "0.4"};
        border-radius: 8px;
        color: ${toRGBA palette.base05 "0.9"};
        padding: 8px 12px;
        font-size: 12px;
      }
      
      tooltip label {
        color: ${toRGBA palette.base05 "0.9"};
      }
      
      #clock tooltip {
        font-family: monospace;
      }
      

      /* Workspace buttons */
      #sway-workspaces button,#niri-workspaces button {
        padding: 0 6px;
        background: transparent;
        color: ${toRGBA palette.base05 "0.9"};
        border: none;
        border-radius: 6px;
      }
      #sway-workspaces button:hover,#niri-workspaces button:hover {
        background-color: ${toRGBA palette.base02 "0.5"};
      }
      #sway-workspaces button.focused,#niri-workspaces button.focused {
        background-color: ${toRGBA palette.base03 "0.6"};
        box-shadow: inset 0 -3px ${toRGBA palette.base05 "0.8"};
      }
      #sway-workspaces button.urgent,#niri-workspaces button.urgent {
        background-color: ${toRGBA palette.base08 "0.7"};
      }

      /* Right‐hand text color */
      #clock,#battery,#cpu,#memory,#temperature,#backlight,
      #network,#pulseaudio,#tray,#power-profiles-daemon,#custom-power {
        color: ${toRGBA palette.base05 "0.9"};
      }

      /* Battery critical blink */
      @keyframes blink {
        to {
          background: ${toRGBA palette.base05 "0.9"};
          color: ${toRGBA palette.base00 "1"};
        }
      }
      #battery.critical:not(.charging) {
        animation: blink 0.5s steps(12) infinite alternate;
      }
    '';

    # Keep Waybar alive in your user session
    systemd.enable = true;
  };
}
