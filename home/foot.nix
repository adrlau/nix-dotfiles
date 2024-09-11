{ pkgs, lib, ... }:
{
    home.packages = with pkgs; [
        foot
    ];
    
    programs.foot.enable = true;
    programs.foot.settings = {
       
       main = {
           term = "xterm-256color";
           font = "0xproto:size=12";
           #dpi-aware = "yes";
       };
       mouse = {
           hide-when-typing = "yes";
       };
     };

 
}

