{ config, pkgs, home-manager, ... }:
{
  imports = [
    (import "${home-manager}/nixos")
    ./code.nix
 ];

  home-manager.users.gunalx = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
  

  };
}
