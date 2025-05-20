{ pkgs, lib, config, ... }:
{
  imports = [
  ];
  nixpkgs.config.allowUnfree = true;
  programs.nix-index.enable = true;

}
