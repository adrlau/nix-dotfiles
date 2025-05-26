{ pkgs, lib, config, ... }:
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


       colors = {
         alpha = "0.7";
         #set based on https://github.com/tinted-theming/base16-foot/blob/main/colors/base16-apathy.ini   and https://github.com/tinted-theming/base16-schemes/blob/main/apathy.yaml

         foreground = "0x${config.colorScheme.palette.base05}";
         background = "0x${config.colorScheme.palette.base00}";

         regular0 = "0x${config.colorScheme.palette.base00}";  
         regular1 = "0x${config.colorScheme.palette.base08}";
         regular2 = "0x${config.colorScheme.palette.base0B}";
         regular3 = "0x${config.colorScheme.palette.base0A}";
         regular4 = "0x${config.colorScheme.palette.base0D}";
         regular5 = "0x${config.colorScheme.palette.base0E}";
         regular6 = "0x${config.colorScheme.palette.base0C}";
         regular7 = "0x${config.colorScheme.palette.base05}";
         
         bright0 = "0x${config.colorScheme.palette.base03}";
         bright1 = "0x${config.colorScheme.palette.base08}";
         bright2 = "0x${config.colorScheme.palette.base0B}";
         bright3 = "0x${config.colorScheme.palette.base0A}";
         bright4 = "0x${config.colorScheme.palette.base0D}";
         bright5 = "0x${config.colorScheme.palette.base0E}";
         bright6 = "0x${config.colorScheme.palette.base0C}";
         bright7 = "0x${config.colorScheme.palette.base07}";
         selection-foreground = "0x${config.colorScheme.palette.base00}";
         selection-background = "0x${config.colorScheme.palette.base0A}";
  };




     };

 
}

