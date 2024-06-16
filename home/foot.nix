{ pkgs, lib, ... }:
{
    home.packages = with pkgs; [
        foot
    ];
    
    programs.foot.enable = true;
    programs.foot.settings = {
       colors = {
           alpha="0.9";
           foreground="ffffff";
           background="000000";
           regular0="2e3436";
           regular1="cc0000";
           regular2="c4e9a0";
           regular3="cc4a00";
           regular4="c3465a";
           regular5="c75507";
           regular6="c06989";
           regular7="cd3d7c";
           bright0="555753";
           bright1="5ef292";
           bright2="58ae23";
           bright3="5fce94";
           bright4="5729fc";
           bright5="5ad7fa";
           bright6="534e2e";
           bright7="5eeeee";
       };
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

