{ pkgs, lib, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type   = "fcitx5";

    fcitx5 = {
      # 1) Load the GTK bridge, the classic UI and the Catppuccin theme package
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-mozc
        catppuccin-fcitx5
      ];

      # 2) Install the Catppuccin theme under $XDG_DATA_HOME/fcitx5/themes/catppuccin
      themes = {
        catppuccin = {
          highlightImage = "${pkgs.catppuccin-fcitx5}/share/fcitx5/themes/catppuccin/highlight.svg";
          panelImage     = "${pkgs.catppuccin-fcitx5}/share/fcitx5/themes/catppuccin/panel.svg";
          theme          = "${pkgs.catppuccin-fcitx5}/share/fcitx5/themes/catppuccin/theme.conf";
        };
      };  # i18n.inputMethod.fcitx5.themes.<name> … [source_id=2]

      settings = {
        # 3) Tell the classic UI to use “catppuccin”
        addons.classicui.globalSection = {
          Theme = "catppuccin";
        };

        # 4) Your other config (hotkey, layouts, IM engines…)
        globalOptions."Global" = {
          TriggerKey = "Control+space";
        };
        inputMethod."Default" = {
          Enabled = "xkb:us::eng,xkb:no::nob,xkb:jp::jpn,mozc";
        };
      };
    };
  };

  # 5) Force your own ExecStart so you never get “conflicting definition” errors
  systemd.user.services.fcitx5-daemon.Service.ExecStart =
    lib.mkForce "${pkgs.fcitx5-with-addons}/bin/fcitx5";
}
