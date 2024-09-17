{ pkgs, config, lib, ... }:
let
  wallpapers = import ./wallpaper.nix { inherit pkgs; };
  palette = config.colorScheme.palette;
in
{
    imports = [
       ./waybar.nix
       ./foot.nix
       ./fonts.nix
       ./kanshi.nix
    ];


    home.packages = with pkgs; [
      wl-clipboard
    	libsForQt5.qt5ct
    	qt6Packages.qt6ct
    	pass-wayland

      #term
    	foot
    	## possible other options
    	#kitty
    	#alacrity


      #disply and background
    	wdisplays
      kanshi
      wlr-randr
      #swaybg
      swww

      #bar applets and notifications
    	waybar
    	networkmanagerapplet
    	networkmanager
    	libsForQt5.networkmanager-qt
      mako

      #lockscreen and related
    	wleave
      swayidle
    	swaylock-effects
    	#swaylock-fancy #migth change to this default may look prettier.

      #ligth and sound
    	brightnessctl
    	pavucontrol

      #sway automation
    	autotiling-rs
      swayest-workstyle

      #launcher
      #wofi
      #wofi-emoji
      bemoji
      fuzzel


      #screenshots
    	grim
    	slurp

      #fonts
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      nerdfonts
      ubuntu_font_family
      zpix-pixel-font
      _0xproto
      font-awesome
      font-awesome_5
      font-awesome_4

    ];

  qt.enable = true;
  qt.style.name = "adwaita-dark";


  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XKB_DEFAULT_OPTIONS = "terminate:ctrl_alt_bksp,caps:escape";
    SDL_VIDEODRIVER = "wayland";

    # needs qt5.qtwayland in systemPackages
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Fix for some Java AWT applications (e.g. Android Studio),
    # use this if they aren't displayed properly:
    _JAVA_AWT_WM_NONREPARENTING = 1;

    # gtk applications on wayland
    #GTK_BACKEND="wayland";
  };


wayland.windowManager.sway = let
  cfg = config.wayland.windowManager.sway;
in {
  wrapperFeatures.gtk = true;
  enable = true;
  systemd.enable = true;


  config = rec {
    
    modifier = "Mod4";

    terminal = "footclient";
    menu = "fuzzel -b ${palette.base00}BB -t ${palette.base05}FF";
    bars = [{
        fonts.size = 16.0;
        command = "waybar";
        position = "top";
      }];
    startup = [
      {command = "foot --server";}
      {command = "swww-daemon";}
      {command = ''while true; do for wallpaper in $WALLPAPER_DIR/*; do swww img "$wallpaper"; sleep 300; done; done'';}

      {command = "firefox";}
      {command = "nm-applet";}
      {command = "autotiling-rs";}
      {command = "sworkstyle";}
    ];
    floating.border = 0;
    window.border = 0;
    focus.followMouse = true;
    modes.resize = {
      Escape = "mode default";
      Return = "mode default";
      "${cfg.config.left}" = "resize shrink width 10 px or 10 ppt";
      "${cfg.config.down}" = "resize grow height 10 px or 10 ppt";
      "${cfg.config.up}" = "resize shrink height 10 px or 10 ppt";
      "${cfg.config.right}" = "resize grow width 10 px or 10 ppt";
      "Left" = "resize shrink width 10 px or 10 ppt";
      "Down" = "resize grow height 10 px or 10 ppt";
      "Up" = "resize shrink height 10 px or 10 ppt";
      "Right" = "resize grow width 10 px or 10 ppt";
    };
    keybindings = {
        "${cfg.config.modifier}+Return" = "exec ${cfg.config.terminal}";
        "${cfg.config.modifier}+Shift+q" = "kill";
        "${cfg.config.modifier}+d" = "exec ${cfg.config.menu}";

        "${cfg.config.modifier}+${cfg.config.left}" = "focus left";
        "${cfg.config.modifier}+${cfg.config.down}" = "focus down";
        "${cfg.config.modifier}+${cfg.config.up}" = "focus up";
        "${cfg.config.modifier}+${cfg.config.right}" = "focus right";

        "${cfg.config.modifier}+Left" = "focus left";
        "${cfg.config.modifier}+Down" = "focus down";
        "${cfg.config.modifier}+Up" = "focus up";
        "${cfg.config.modifier}+Right" = "focus right";

        "${cfg.config.modifier}+Shift+${cfg.config.left}" = "move left";
        "${cfg.config.modifier}+Shift+${cfg.config.down}" = "move down";
        "${cfg.config.modifier}+Shift+${cfg.config.up}" = "move up";
        "${cfg.config.modifier}+Shift+${cfg.config.right}" = "move right";

        "${cfg.config.modifier}+Shift+Left" = "move left";
        "${cfg.config.modifier}+Shift+Down" = "move down";
        "${cfg.config.modifier}+Shift+Up" = "move up";
        "${cfg.config.modifier}+Shift+Right" = "move right";

        "${cfg.config.modifier}+b" = "splith";
        "${cfg.config.modifier}+v" = "splitv";
        "${cfg.config.modifier}+f" = "fullscreen toggle";
        "${cfg.config.modifier}+a" = "focus parent";

        "${cfg.config.modifier}+s" = "layout stacking";
        "${cfg.config.modifier}+w" = "layout tabbed";
        "${cfg.config.modifier}+e" = "layout toggle split";

        "${cfg.config.modifier}+Shift+space" = "floating toggle";
        "${cfg.config.modifier}+space" = "focus mode_toggle";

        "${cfg.config.modifier}+1" = "workspace number 1";
        "${cfg.config.modifier}+2" = "workspace number 2";
        "${cfg.config.modifier}+3" = "workspace number 3";
        "${cfg.config.modifier}+4" = "workspace number 4";
        "${cfg.config.modifier}+5" = "workspace number 5";
        "${cfg.config.modifier}+6" = "workspace number 6";
        "${cfg.config.modifier}+7" = "workspace number 7";
        "${cfg.config.modifier}+8" = "workspace number 8";
        "${cfg.config.modifier}+9" = "workspace number 9";
        "${cfg.config.modifier}+0" = "workspace number 10";

        "${cfg.config.modifier}+Shift+1" = "move container to workspace number 1";
        "${cfg.config.modifier}+Shift+2" = "move container to workspace number 2";
        "${cfg.config.modifier}+Shift+3" = "move container to workspace number 3";
        "${cfg.config.modifier}+Shift+4" = "move container to workspace number 4";
        "${cfg.config.modifier}+Shift+5" = "move container to workspace number 5";
        "${cfg.config.modifier}+Shift+6" = "move container to workspace number 6";
        "${cfg.config.modifier}+Shift+7" = "move container to workspace number 7";
        "${cfg.config.modifier}+Shift+8" = "move container to workspace number 8";
        "${cfg.config.modifier}+Shift+9" = "move container to workspace number 9";
        "${cfg.config.modifier}+Shift+0" = "move container to workspace number 10";

        "${cfg.config.modifier}+Shift+minus" = "move scratchpad";
        "${cfg.config.modifier}+minus" = "scratchpad show";

        "${cfg.config.modifier}+Shift+r" = "reload";
        "${cfg.config.modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "${cfg.config.modifier}+r" = "mode resize";

        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86Search" = "exec ${cfg.config.menu}";

        "${cfg.config.modifier}+Shift+f" = "exec firefox";
        "${cfg.config.modifier}+Shift+c" = "exec code";
        "${cfg.config.modifier}+f11" = "exec grim -g \"$(slurp)\" ~/Pictures/screenshots/\"screenshot-`date +%F-%T`\".png";
        "${cfg.config.modifier}+Print" = "exec grim -g \"$(slurp)\" ~/Pictures/screenshots/\"screenshot-`date +%F-%T`\".png";
        "${cfg.config.modifier}+tab" = "workspace next";
        "Alt+tab" = "workspace back_and_forth";
        };
  };

  extraConfig = ''
    input type:keyboard xkb_capslock disabled
    input type:keyboard xkb_numlock enabled
    xwayland enable

    smart_borders no_gaps
    smart_gaps on
    gaps inner 5
    default_border pixel 1
    default_floating_border pixel 2
    titlebar_border_thickness 1

    client.focused          #${palette.base0D} #${palette.base00} #${palette.base05} #${palette.base0D} #${palette.base0D}
    client.focused_inactive #${palette.base0D} #${palette.base00} #${palette.base05} #${palette.base0D} #${palette.base0D}
    client.unfocused        #${palette.base0D} #${palette.base03} #${palette.base05} #${palette.base0D} #${palette.base00}
    client.urgent           #${palette.base0D} #${palette.base0D} #${palette.base03} #${palette.base0D} #${palette.base00}

    for_window [title="(?:Open|Save) (?:File|Folder|As)"] floating enable
    for_window [title="(?:Open|Save) (?:File|Folder|As)"] resize set 1920 1080
    for_window [window_role="pop-up"] floating enable
    for_window [window_role="bubble"] floating enable
    for_window [window_role="task_dialog"] floating enable
    for_window [window_role="Preferences"] floating enable
    for_window [window_type="dialog"] floating enable
    for_window [window_type="menu"] floating enable
    for_window [app_id="xdg-desktop-portal-gtk"] floating enable
    for_window [app_id="xdg-desktop-portal-gtk"] resize set 1920 1080
    for_window [app_id="bitwarden"] floating enable
    for_window [app_id="dolphin"] floating enable
    for_window [app_id="file-manager"] floating enable

  '';
};
}

