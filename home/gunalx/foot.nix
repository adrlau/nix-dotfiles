{ pkgs, lib, config, ... }:
{
    home.packages = with pkgs; [
        foot
    ];
    
    programs.foot.enable = true;
    programs.foot.settings = {
       
       main = {
           term = "xterm-256color";
           font = "0xproto:size=14";
           #dpi-aware = "yes";
       };
       mouse = {
           hide-when-typing = "yes";
         };


       colors = {
         alpha = "0.7";
         foreground = "${config.colorScheme.palette.base05}";
         background = "${config.colorScheme.palette.base00}";

         regular0 = "${config.colorScheme.palette.base00}";  
         regular1 = "${config.colorScheme.palette.base08}";
         regular2 = "${config.colorScheme.palette.base0B}";
         regular3 = "${config.colorScheme.palette.base0A}";
         regular4 = "${config.colorScheme.palette.base0D}";
         regular5 = "${config.colorScheme.palette.base0E}";
         regular6 = "${config.colorScheme.palette.base0C}";
         regular7 = "${config.colorScheme.palette.base05}";
         
         bright0 = "${config.colorScheme.palette.base03}";
         bright1 = "${config.colorScheme.palette.base08}";
         bright2 = "${config.colorScheme.palette.base0B}";
         bright3 = "${config.colorScheme.palette.base0A}";
         bright4 = "${config.colorScheme.palette.base0D}";
         bright5 = "${config.colorScheme.palette.base0E}";
         bright6 = "${config.colorScheme.palette.base0C}";
         bright7 = "${config.colorScheme.palette.base07}";
         selection-foreground = "${config.colorScheme.palette.base00}";
         selection-background = "${config.colorScheme.palette.base0A}";
  };




     };

 
}

