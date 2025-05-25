{ pkgs, config, lib, ... }:

{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
    settings = {
      main = {
        terminal = "${pkgs.foot}/bin/foot";
        layer    = "overlay";
      };
      colors = {
        background = "ffffffff";
      };
    };
  };
}
