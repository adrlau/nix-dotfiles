{ pkgs, config, lib, ... }:
let
  palette = config.colorScheme.palette;

  niriConfig = ''
    // KDL‐format niri config

    input {
      keyboard { xkb { layout "us,no"; options "grp:ctrl_space_toggle"; }; }
      touchpad {
        tap
        natural-scroll
        accel-speed 0.1
        accel-profile "flat"
      }
      warp-mouse-to-focus
      focus-follows-mouse max-scroll-amount="0%"
    }

    output "AU Optronics 0x212B Unknown" {
      mode "3840x2160@60.002"
      //focus-at-startup
      scale 2
      transform "normal"
      position x=1920 y=2160
    }
    output "ASUSTek COMPUTER INC ASUS MB16AH L9LMTF068515" {
      mode "1920x1080@60.000"
      scale 1
      transform "normal"
      position x=1920 y=1080
    }
    output "Hewlett Packard HP ZR24w CNT01710L4" {
      mode "1920x1200@60.000"
      scale 1
      transform "normal"
      position x=960 y=960
    }
    output "Hewlett Packard HP ZR24w CNT0181039" {
      mode "1920x1200@60.000"
      scale 1
      transform "normal"
      position x=2880 y=960
    }

    //desktop outputs.
    output "Dell Inc. DELL U2410 F525M06G123L" {
      mode "2560x1440@144.000"
      scale 1
      transform "90"
      position x=0 y=0
    }
    output "Samsung Electric Company LC27G5xT H4LR800468" {
      mode "1920x1200@59.950"
      variable-refresh-rate on-demand=true
      //focus-at-startup
      scale 1
      transform "normal"
      position x=1200 y=240
    }

//switch events for open closing lid.
switch-events {
    lid-close { spawn "swaylock"; }
    //lid-open { spawn "notify-send" "The laptop lid is open!"; }
    tablet-mode-on { spawn "bash" "-c" "wvkbd-mobintl"; }
    tablet-mode-off { spawn "bash" "-c" "pkill   wvkbd-mobintl"; }
}


// Settings that influence how windows are positioned and sized.
// Find more information on the wiki:
// https://github.com/YaLTeR/niri/wiki/Configuration:-Layout
layout {
    // Set gaps around windows in logical pixels.
    gaps 8

    // When to center a column when changing focus, options are:
    // - "never", default behavior, focusing an off-screen column will keep at the left
    //   or right edge of the screen.
    // - "always", the focused column will always be centered.
    // - "on-overflow", focusing a column will center it if it doesn't fit
    //   together with the previously focused column.
    center-focused-column "on-overflow"

    // You can customize the widths that "switch-preset-column-width" (Mod+R) toggles between.
    preset-column-widths {
        // Proportion sets the width as a fraction of the output width, taking gaps into account.
        // For example, you can perfectly fit four windows sized "proportion 0.25" on an output.
        // The default preset widths are 1/3, 1/2 and 2/3 of the output but that is annoying.
        proportion 0.3333333
        proportion 0.5
        proportion 0.6666667

        // Fixed sets the width in logical pixels exactly.
        // fixed 1920
    }

    // You can also customize the heights that "switch-preset-window-height" (Mod+Shift+R) toggles between.
    preset-window-heights {
      proportion 1.0
      proportion 0.5

    }

    // You can change the default width of the new windows.
    default-column-width { proportion 1.0; }
    // If you leave the brackets empty, the windows themselves will decide their initial width.
    // default-column-width {}

    // By default focus ring and border are rendered as a solid background rectangle
    // behind windows. That is, they will show up through semitransparent windows.
    // This is because windows using client-side decorations can have an arbitrary shape.
    // If you don't like that, you should uncomment `prefer-no-csd` below.
    // Niri will draw focus ring and border *around* windows that agree to omit their
    // client-side decorations.
    // Alternatively, you can override it with a window rule called
    // `draw-border-with-background`.

    // You can change how the focus ring looks.
    focus-ring {
        // Uncomment this line to disable the focus ring.
        // off
        
	      // How many logical pixels the ring extends out from the windows.
        width 2

        // Colors can be set in a variety of ways:
        // - CSS named colors: "red"
        // - RGB hex: "#rgb", "#rgba", "#rrggbb", "#rrggbbaa"
        // - CSS-like notation: "rgb(255, 127, 0)", rgba(), hsl() and a few others.

        // Color of the ring on the active monitor.
        active-color "${palette.base0D}"

        // Color of the ring on inactive monitors.
        inactive-color "${palette.base03}"

        // You can also use gradients. They take precedence over solid colors.
        // Gradients are rendered the same as CSS linear-gradient(angle, from, to).
        // The angle is the same as in linear-gradient, and is optional,
        // defaulting to 180 (top-to-bottom gradient).
        // You can use any CSS linear-gradient tool on the web to set these up.
        // Changing the color space is also supported, check the wiki for more info.
        //
        // active-gradient from="#80c8ff" to="#bbddff" angle=45

        // You can also color the gradient relative to the entire view
        // of the workspace, rather than relative to just the window itself.
        // To do that, set relative-to="workspace-view".
        //
        // inactive-gradient from="#505050" to="#808080" angle=45 relative-to="workspace-view"
    }

    // You can also add a border. It's similar to the focus ring, but always visible.
    border {
        // The settings are the same as for the focus ring.
        // If you enable the border, you probably want to disable the focus ring.
        off
        width 2
        active-color "${palette.base0A}"
        inactive-color "${palette.base03}"
        // active-gradient from="#ffbb66" to="#ffc880" angle=45 relative-to="workspace-view"
        // inactive-gradient from="#505050" to="#808080" angle=45 relative-to="workspace-view"
    }

    // You can enable drop shadows for windows.
    shadow {
        // Uncomment the next line to enable shadows.
        on

        // By default, the shadow draws only around its window, and not behind it.
        // Uncomment this setting to make the shadow draw behind its window.
        //
        // Note that niri has no way of knowing about the CSD window corner
        // radius. It has to assume that windows have square corners, leading to
        // shadow artifacts inside the CSD rounded corners. This setting fixes
        // those artifacts.
        // 
        // However, instead you may want to set prefer-no-csd and/or
        // geometry-corner-radius. Then, niri will know the corner radius and
        // draw the shadow correctly, without having to draw it behind the
        // window. These will also remove client-side shadows if the window
        // draws any.
        // 
        //draw-behind-window false

        // You can change how shadows look. The values below are in logical
        // pixels and match the CSS box-shadow properties.

        // Softness controls the shadow blur radius.
        softness 30

        // Spread expands the shadow.
        spread 5

        // Offset moves the shadow relative to the window.
        offset x=0 y=5

        // You can also change the shadow color and opacity.
        color "#0007"
    }

    // Struts shrink the area occupied by windows, similarly to layer-shell panels.
    // You can think of them as a kind of outer gaps. They are set in logical pixels.
    // Left and right struts will cause the next window to the side to always be visible.
    // Top and bottom struts will simply add outer gaps in addition to the area occupied by
    // layer-shell panels and regular gaps.
    struts {
        left 24
        right 24
        // top 64
        // bottom 64
    }
}

overview {
    zoom 0.5
    backdrop-color "#${palette.base00}"
}

// Add lines like this to spawn processes at startup.
// Note that running niri as a session supports xdg-desktop-autostart,
// which may be more convenient to use.
// See the binds section below for more spawn examples.
// spawn-at-startup "alacritty" "-e" "fish"
spawn-at-startup "foot" "--server"
spawn-at-startup "xwayland-satellite"
spawn-at-startup "mako"
spawn-at-startup "swww-daemon"
//spawn-at-startup "waybar" //spawns by system service instead
spawn-at-startup "swayidle" "-w" "timeout" "601" "niri msg action power-off-monitors" "timeout" "600" "swaylock -f" "before-sleep" "swaylock -f"

// Uncomment this line to ask the clients to omit their client-side decorations if possible.
// If the client will specifically ask for CSD, the request will be honored.
// Additionally, clients will be informed that they are tiled, removing some client-side rounded corners.
// This option will also fix border/focus ring drawing behind some semitransparent windows.
// After enabling or disabling this, you need to restart the apps for this to take effect.
prefer-no-csd

// You can change the path where screenshots are saved.
// A ~ at the front will be expanded to the home directory.
// The path is formatted with strftime(3) to give you the screenshot date and time.
screenshot-path "~/Pictures/screenshots/screenshot-%Y-%m-%d %H-%M-%S.png"

// Animation settings.
// The wiki explains how to configure individual animations:
// https://github.com/YaLTeR/niri/wiki/Configuration:-Animations
animations {
    // Uncomment to turn off all animations.
    off

    // Slow down all animations by this factor. Values below 1 speed them up instead.
    // slowdown 0.3

}


layer-rule {
    match namespace="^notifications$"
    block-out-from "screencast"
}

// Window rules let you adjust behavior for individual windows.
// Find more information on the wiki:
// https://github.com/YaLTeR/niri/wiki/Configuration:-Window-Rules



// Floating Bitwarden extension popup windows only
window-rule {
    match title=r#"^Extension: \(Bitwarden Password Manager\) - Bitwarden — Mozilla Firefox$"#
    match title="^Extension: (Bitwarden Password Manager) - Bitwarden — Mozilla Firefox$"
    match app-id=r#"(?i)^bitwarden$"#
    open-floating true
    default-column-width { proportion 0.3;}
    default-floating-position x=0 y=0 relative-to="top-left"
    opacity 0.9
    block-out-from "screen-capture"
}

// dropdown terminal
window-rule {
    match title="^dropdown$"
    open-focused true
    open-floating true
    default-floating-position x=0 y=0 relative-to="top"
    default-window-height { proportion 0.5; }
    // 80% of the screen wide.
    default-column-width { proportion 0.8; }
    // block-out-from "screencast"
    block-out-from "screen-capture"
}

//fix steam notifications to bottom rigth
window-rule {
    match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
    default-floating-position x=10 y=10 relative-to="bottom-right"
    //block-out-from "screencast"
    block-out-from "screen-capture"
}


window-rule {
    geometry-corner-radius 12
    clip-to-geometry true
}

window-rule {
    match app-id="onboard"
    match app-id="Onboard"
    open-floating true
    default-window-height { proportion 0.2; }
    default-column-width { proportion 0.8; }
    block-out-from "screen-capture"
}

binds {
    // Keys consist of modifiers separated by + signs, followed by an XKB key name
    // in the end. To find an XKB name for a particular key, you may use a program
    // like wev.
    //
    // "Mod" is a special modifier equal to Super when running on a TTY, and to Alt
    // when running as a winit window.
    //
    // Most actions that you can bind here can also be invoked programmatically with
    // `niri msg action do-something`.

    // Mod-Shift-/, which is usually the same as Mod-?,
    // shows a list of important hotkeys.
    Mod+Shift+Slash { show-hotkey-overlay; }
    Mod+Slash { toggle-overview; }

    // Suggested binds for running programs: terminal, app launcher, screen locker.
    Mod+Return { spawn "footclient"; }
    Mod+T { spawn  "sh" "-c" "if pgrep -f '^foot -T dropdown$' >/dev/null; then pkill -f '^foot -T dropdown$'; else exec foot -T dropdown; fi"; }
    Mod+D { spawn "fuzzel"; }
    Mod+M { spawn "swaylock" "--grace" "0"; }
    Mod+O { toggle-window-rule-opacity; }

    // You can also use a shell. Do this if you need pipes, multiple commands, etc.
    // Note: the entire command goes as a single argument in the end.
    // Mod+T { spawn "bash" "-c" "notify-send hello && exec alacritty"; }

    // Example volume keys mappings for PipeWire & WirePlumber.
    // The allow-when-locked=true property makes them work even when the session is locked.
    XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
    XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
    XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

    Mod+Shift+Q { close-window; }

    Mod+Left  { focus-column-or-monitor-left; }
    Mod+Down  { focus-window-or-monitor-down; }
    Mod+Up    { focus-window-or-monitor-up; }
    Mod+Right { focus-column-or-monitor-right; }
    Mod+H     { focus-column-or-monitor-left; }
    Mod+J     { focus-window-or-monitor-down; }
    Mod+K     { focus-window-or-monitor-up; }
    Mod+L     { focus-column-or-monitor-right; }

    Alt+Tab   { focus-window-previous; }

    Mod+Ctrl+Left  { move-column-left; }
    Mod+Ctrl+Down  { move-window-down; }
    Mod+Ctrl+Up    { move-window-up; }
    Mod+Ctrl+Right { move-column-right; }
    Mod+Ctrl+H     { move-column-left; }
    Mod+Ctrl+J     { move-window-down; }
    Mod+Ctrl+K     { move-window-up; }
    Mod+Ctrl+L     { move-column-right; }

    // Alternative commands that move across workspaces when reaching
    // the first or last window in a column.
    // Mod+J     { focus-window-or-workspace-down; }
    // Mod+K     { focus-window-or-workspace-up; }
    // Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
    // Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }

    Mod+Home { focus-column-first; }
    Mod+End  { focus-column-last; }
    Mod+Ctrl+Home { move-column-to-first; }
    Mod+Ctrl+End  { move-column-to-last; }

    Mod+Shift+Left  { focus-monitor-left; }
    Mod+Shift+Down  { focus-monitor-down; }
    Mod+Shift+Up    { focus-monitor-up; }
    Mod+Shift+Right { focus-monitor-right; }
    Mod+Shift+H     { focus-monitor-left; }
    Mod+Shift+J     { focus-monitor-down; }
    Mod+Shift+K     { focus-monitor-up; }
    Mod+Shift+L     { focus-monitor-right; }

    Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
    Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
    Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
    Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
    Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
    Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

    // Alternatively, there are commands to move just a single window:
    // Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
    // ...

    // And you can also move a whole workspace to another monitor:
    // Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
    // ...

    Mod+Page_Down      { focus-workspace-down; }
    Mod+Page_Up        { focus-workspace-up; }
    Mod+U              { focus-workspace-down; }
    Mod+I              { focus-workspace-up; }
    Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
    Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
    Mod+Ctrl+U         { move-column-to-workspace-down; }
    Mod+Ctrl+I         { move-column-to-workspace-up; }


    Mod+Shift+Page_Down { move-workspace-down; }
    Mod+Shift+Page_Up   { move-workspace-up; }
    Mod+Shift+U         { move-workspace-down; }
    Mod+Shift+I         { move-workspace-up; }

    // You can bind mouse wheel scroll ticks using the following syntax.
    // These binds will change direction based on the natural-scroll setting.
    //
    // To avoid scrolling through workspaces really fast, you can use
    // the cooldown-ms property. The bind will be rate-limited to this value.
    // You can set a cooldown on any bind, but it's most useful for the wheel.
    Mod+Shift+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
    Mod+Shift+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
    Mod+Shift+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
    Mod+Ctrl+Shift+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

    Mod+WheelScrollRight       cooldown-ms=150 { focus-column-right; }
    Mod+WheelScrollLeft        cooldown-ms=150 { focus-column-left; }
    Mod+Ctrl+WheelScrollRight  cooldown-ms=150 { move-column-right; }
    Mod+Ctrl+WheelScrollLeft   cooldown-ms=150 { move-column-left; }

    // Usually scrolling up and down with Shift in applications results in
    // horizontal scrolling; these binds replicate that. 
    // But i found it impractical.  workspaces i can graphically cahnge. and probably more rarly, so i swapped it
    Mod+WheelScrollDown       cooldown-ms=150 { focus-column-right; }
    Mod+WheelScrollUp         cooldown-ms=150 { focus-column-left; }
    Mod+Ctrl+WheelScrollDown  cooldown-ms=150 { move-column-right; }
    Mod+Ctrl+WheelScrollUp    cooldown-ms=150 { move-column-left; }

    // Similarly, you can bind touchpad scroll "ticks".
    // Touchpad scrolling is continuous, so for these binds it is split into
    // discrete intervals.
    // These binds are also affected by touchpad's natural-scroll, so these
    // example binds are "inverted", since we have natural-scroll enabled for
    // touchpads by default.
    // Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
    // Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

    // You can refer to workspaces by index. However, keep in mind that
    // niri is a dynamic workspace system, so these commands are kind of
    // "best effort". Trying to refer to a workspace index bigger than
    // the current workspace count will instead refer to the bottommost
    // (empty) workspace.
    //
    // For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
    // will all refer to the 3rd workspace.
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }
    Mod+Ctrl+1 { move-column-to-workspace 1; }
    Mod+Ctrl+2 { move-column-to-workspace 2; }
    Mod+Ctrl+3 { move-column-to-workspace 3; }
    Mod+Ctrl+4 { move-column-to-workspace 4; }
    Mod+Ctrl+5 { move-column-to-workspace 5; }
    Mod+Ctrl+6 { move-column-to-workspace 6; }
    Mod+Ctrl+7 { move-column-to-workspace 7; }
    Mod+Ctrl+8 { move-column-to-workspace 8; }
    Mod+Ctrl+9 { move-column-to-workspace 9; }

    // Alternatively, there are commands to move just a single window:
    // Mod+Ctrl+1 { move-window-to-workspace 1; }

    // Switches focus between the current and the previous workspace.
    // Mod+Tab { focus-workspace-previous; }

    // The following binds move the focused window in and out of a column.
    // If the window is alone, they will consume it into the nearby column to the side.
    // If the window is already in a column, they will expel it out.
    Mod+BracketLeft  { consume-or-expel-window-left; }
    Mod+BracketRight { consume-or-expel-window-right; }

    // Consume one window from the right to the bottom of the focused column.
    Mod+Comma  { consume-window-into-column; }
    // Expel the bottom window from the focused column to the right.
    Mod+Period { expel-window-from-column; }

    Mod+R { switch-preset-column-width; }
    Mod+Shift+R { switch-preset-window-height; }
    Mod+Ctrl+R { reset-window-height; }
    Mod+F { maximize-column; }
    Mod+Shift+F { fullscreen-window; }
    Mod+Ctrl+Shift+F { toggle-windowed-fullscreen; }
   
    // Expand the focused column to space not taken up by other fully visible columns.
    // Makes the column "fill the rest of the space".
    Mod+Ctrl+F { expand-column-to-available-width; }

    Mod+C { center-column; }

    // Finer width adjustments.
    // This command can also:
    // * set width in pixels: "1000"
    // * adjust width in pixels: "-5" or "+5"
    // * set width as a percentage of screen width: "25%"
    // * adjust width as a percentage of screen width: "-10%" or "+10%"
    // Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
    // set-column-width "100" will make the column occupy 200 physical screen pixels.
    Mod+Minus { set-column-width "-10%"; }
    Mod+Equal { set-column-width "+10%"; }
    Mod+0 { set-column-width "+10%"; }

    // Finer height adjustments when in column with other windows.
    Mod+Shift+Minus { set-window-height "-10%"; }
    Mod+Shift+Equal { set-window-height "+10%"; }
    Mod+Shift+0 { set-window-height "+10%"; }

    // Move the focused window between the floating and the tiling layout.
    Mod+V       { toggle-window-floating; }
    Mod+Shift+V { switch-focus-between-floating-and-tiling; }

    // Toggle tabbed column display mode.
    // Windows in this column will appear as vertical tabs,
    // rather than stacked on top of each other.
    Mod+W { toggle-column-tabbed-display; }

    // Actions to switch layouts.
    // Note: if you uncomment these, make sure you do NOT have
    // a matching layout switch hotkey configured in xkb options above.
    // Having both at once on the same hotkey will break the switching,
    // since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
    // Mod+Space       { switch-layout "next"; }
    // Mod+Shift+Space { switch-layout "prev"; }

    Print { screenshot; }
    Ctrl+Print { screenshot-screen; }
    Alt+Print { screenshot-window; }

    // Applications such as remote-desktop clients and software KVM switches may
    // request that niri stops processing the keyboard shortcuts defined here
    // so they may, for example, forward the key presses as-is to a remote machine.
    // It's a good idea to bind an escape hatch to toggle the inhibitor,
    // so a buggy application can't hold your session hostage.
    //
    // The allow-inhibiting=false property can be applied to other binds as well,
    // which ensures niri always processes them, even when an inhibitor is active.
    Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

    // The quit action will show a confirmation dialog to avoid accidental exits.
    Mod+Shift+E { quit; }
    Ctrl+Alt+Delete { quit; }

    // Powers off the monitors. To turn them back on, do any input like
    // moving the mouse or pressing any other key.
    Mod+Shift+P { power-off-monitors; }
}


//Enviroment to be set.
environment {
    DISPLAY ":0"
    ELECTRON_OZONE_PLATFORM_HINT "auto"
}

  '';


in
{
    imports = [
       ./waybar.nix
       ./wallpapers.nix
       ./foot.nix
       ./swaylock.nix
       ./wlogout.nix
       ./mako.nix
       ./fcitx5.nix
       ./fuzzel.nix
    ];


    home.packages = with pkgs; [
      niri
      wl-clipboard
      pass-wayland
      wev

      #term
    	foot
      alacritty


    	wdisplays
      swww

      xwayland-satellite

      #bar applets and notifications
    	waybar
    	networkmanagerapplet
    	networkmanager
    	libsForQt5.networkmanager-qt
      

      mako

      swayidle

      #ligth and sound
    	brightnessctl
    	pavucontrol

      fuzzel

      emote

        
       wvkbd


      xdg-desktop-portal-gtk
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome


      #fonts
      _0xproto
      font-awesome
      font-awesome_5
      font-awesome_4

    ];

  # Drop the interpolated KDL into ~/.config/niri/config.kdl
  home.file.".config/niri/config.kdl" = {
    text = niriConfig;
  };
}
