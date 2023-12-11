{pkgs, lib, ...}:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  home-manager.users.gunalx = {
      #vscode with home manager
      programs.vscode = {
		enable = true;
  		enableUpdateCheck = false;
    		package = unstable.vscode-fhs;
 	
      };
  };
}
