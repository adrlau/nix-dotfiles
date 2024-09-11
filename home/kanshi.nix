{ pkgs, lib, ... }:
{
    home.packages = with pkgs; [
    ];

     services.kanshi = {
        enable = true;
        settings = [
          { 
            profile.name = "undocked";
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
   
}

