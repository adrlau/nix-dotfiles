{ pkgs, lib, ... }:
{
    imports = [
        
    ];

  
    home.packages = with pkgs; [
        wl-clipboard
        wlr-randr

    	libsForQt5.qt5ct
    	qt6Packages.qt6ct
	
    	waybar
    	networkmanagerapplet
    	networkmanager
    	libsForQt5.networkmanager-qt
    	
    	wdisplays
        kanshi
    
    	swaylock-effects
        swayidle
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
        
        mako 
    	
        swaybg
    
        swayest-workstyle
    	autotiling-rs
    	wleave	
    	
    	pass-wayland




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
  qt.style.name = "breeze";

  programs.wofi = {
        enable = true;
        settings = {
            location = "center";
            allow_markup = true;
            width = "80%";
          };
        style = ''
                  * {
                      font-family: monospace;
                      font-size: 1.5em;
                  }

                  window {
                      margin: 0px;
                      border: 1px solid #c0c0c0;
                      background-color: #282a36;
                  }
                  
                  #input {
                      margin: 2 px;
                      border: none;
                      color: #222222;
                      background-color: #eeeeee;
                  }
                  
                  #inner-box {
                      margin: 2px;
                      border: none;
                      background-color: #282a36;
                  }
                  
                  #outer-box {
                      margin: 2px;
                      border: none;
                      background-color: #282a36;
                  }
                  
                  #scroll {
                      margin: 0px;
                      border: none;
                  }
                  
                  #text {
                      margin: 2px;
                      border: none;
                      color: #f8f8f2;
                  }
                  
                  #entry:selected {
                      background-color: #44475a;
                  }
                  #entry {
                      border-bottom-style: solid;
                      border-width: 1px;
                      border-color: #d4af37;
                  }
            '';
    };

    services.kanshi = {
        enable = true;
        settings = [
              { profile.name = "undocked";
                  profile.outputs = [
                    {
                      criteria = "eDP-1";
                    }
                  ];
                  profile.exec = [
                        "\${pkg.sway}/bin/swaymsg workspace 1, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 2, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 3, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 4, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 5, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 6, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 7, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 8, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 9, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 10, move workspace to eDP-1"
                        "\${pkg.sway}/bin/swaymsg workspace 0, move workspace to eDP-1"

                  ];
            }
         ];

    };

    programs.foot.settings = {
       colors = {
           alpha="0.9";
           foreground="ffffff";
           background="000000";
           regular0="2e3436";
           regular1="cc0000";
           regular2="c4e9a06";
           regular3="cc4a000";
           regular4="c3465a4";
           regular5="c75507b";
           regular6="c06989a";
           regular7="cd3d7cf";
           bright0="555753";
           bright1="5ef2929";
           bright2="58ae234";
           bright3="5fce94f";
           bright4="5729fcf";
           bright5="5ad7fa8";
           bright6="534e2e2";
           bright7="5eeeeec";
       };
       main = {
           term = "xterm-256color";
           font = "0xproto:size=16";
           dpi-aware = "yes";
       };
       mouse = {
           hide-when-typing = "yes";
       };
     };


  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
      emoji = ["noto-fonts-emoji font-awesome"];
      monospace = ["0xproto" "zpix" "fira-code"];
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XKB_DEFAULT_OPTIONS = "terminate:ctrl_alt_bksp,caps:escape,altwin:swap_alt_win";
    SDL_VIDEODRIVER = "wayland";

    # needs qt5.qtwayland in systemPackages
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Fix for some Java AWT applications (e.g. Android Studio),
    # use this if they aren't displayed properly:
    _JAVA_AWT_WM_NONREPARENTING = 1;

    # gtk applications on wayland
    # export GDK_BACKEND=wayland
  };

    
    
  wayland.windowManager.sway = {
    wrapperFeatures.gtk = true;
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "footclient"; 
      menu = "wofi --show run";
      bars = [{
          fonts.size = 16.0;
          command = "waybar";
          position = "top";
        }];
      startup = [
        # Launch Firefox on start
        {command = "foot --server";}
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
        "h" = "resize shrink width 10 px or 10 ppt";
        "j" = "resize grow height 10 px or 10 ppt";
        "k" = "resize shrink height 10 px or 10 ppt";
        "l" = "resize grow width 10 px or 10 ppt";
      };

    };

    extraConfig = ''
        set $mod Mod4

        #startup
        input type:keyboard xkb_capslock disabled
        input type:keyboard xkb_numlock enabled
        xwayland enable
        
        #autostart to selected workspace classes
        assign [class="autostart1"] workspace 1
        assign [class="autostart2"] workspace 2
        assign [class="autostart3"] workspace 3
        assign [class="autostart4"] workspace 4


        bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
        bindsym F3 exec pactl set-sink-volume @DEFAULT_SINK@ +5%
        bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
        bindsym F2 exec pactl set-sink-volume @DEFAULT_SINK@ -5%
        bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
        bindsym XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle
        bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
        bindsym XF86MonBrightnessUp exec brightnessctl set 5%+
        bindsym XF86AudioPlay exec playerctl play-pause
        bindsym XF86AudioNext exec playerctl next
        bindsym XF86AudioPrev exec playerctl previous
        bindsym XF86Search exec $menu

        #shortcuts for applications
        #bindsym $mod+Shift+f exec firefox
        #bindsym $mod+Shift+c exec code
   


        #screenshot
        bindsym $mod+f11 exec grim -g "$(slurp)" ~/Pictures/screenshots/"screenshot-`date +%F-%T`".png
        bindsym $mod+Print exec grim -g "$(slurp)" ~/Pictures/screenshots/"screenshot-`date +%F-%T`".png

        # Alt tab window switching.
        #bindsym $mod+tab workspace next_on_output 
        #bindsym $mod+Shift+tab workspace prev_on_output
        bindsym Mod1+tab workspace back_and_forth
      '';


  };


}

