{ config, pkgs, lib, ... }:
{
imports =
    [ 
      ../packages/vim.nix
      ./sops.nix
    ];

  #nix stuff
  nix.gc.automatic = true;
  system.autoUpgrade.enable = true;

}