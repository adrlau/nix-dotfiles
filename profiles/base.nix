{ config, pkgs, lib, ... }:
{
imports =
    [ 
      ../packages/vim.nix
      ../services/ssh.nix
    ];

  #nix stuff
  nix.gc.automatic = true;
  system.autoUpgrade.enable = true;

}
