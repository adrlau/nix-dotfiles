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

 
}

