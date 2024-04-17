{pkgs, lib, ...}:
{
  
  unstable.config.allowUnfree = true;
  home-manager.users.gunalx = {
      #vscode with home manager
      programs.vscode = {
		enable = true;
  		enableUpdateCheck = false;
    		package = unstable.vscode-fhs;
 	
      };
  };
}
