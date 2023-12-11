{ config, pkgs, lib, ... }:
{
imports =
    [
      ./base.nix 
      ../packages/vim.nix
      ../home/code.nix
      ../packages/steam.nix
    ];


}
