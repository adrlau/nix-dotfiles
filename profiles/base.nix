{ config, pkgs, lib, ... }:
{
imports =
    [ 
      ../packages/vim.nix
      ../services/ssh.nix
    ];

  #system vide bash aliases.
  environment.shellAliases = {
      gst="git status";
      gcm="git commit -m";
      gsw="git switch";
      gaa="git add -A";
      gb="git branch"; 
      dc="cd";
      la="ls -la";
      lls="ls"; 
  };

  programs.bash.shellAliases = config.environment.shellAliases;

  

  environment.interactiveShellInit = ''
    alias gst='git status'
    alias gcm='git commit -m'
    alias gsw='git switch'
    alias gaa='git add -A'
    alias gb='git branch'
    alias dc='cd'
    alias la='ls -la'
    alias lls='ls'
  '';

  #nix stuff
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc.automatic = true;
  system.autoUpgrade.enable = true;
  
}
