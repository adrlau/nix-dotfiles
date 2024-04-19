{ config, pkgs, lib, ... }:
{
imports =
    [ 
      ../packages/vim.nix
      ../services/ssh.nix
    ];


  environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      git
      wget
      rsync
      ripgrep
      neofetch
      htop
      bottom
      killall
      foot.terminfo
      tailscale
    ];

  #just allow unfree, im fine with it. 
  nixpkgs.config.allowUnfree = true; 
  

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure console
  console = {
    font = "Lat2-Terminus16";
    keyMap = "no";
  };

  #tailscale
  services.tailscale.enable = true;

  #system vide bash aliases. TODO: check if only one of these works so i dont need duplicates.
  programs.bash.shellAliases = config.environment.shellAliases;
  environment.shellAliases = {
      gst="git status";
      gcm="git commit -m";  
      gca="git commit --amend";  
      gsw="git switch";
      gaa="git add -A";
      gb="git branch"; 
      dc="cd";
      la="ls -la";
      lls="ls"; 
  };
  environment.interactiveShellInit = ''
    alias gst='git status'
    alias gcm='git commit -m'
    alias gca='git commit --amend'
    alias gsw='git switch'
    alias gaa='git add -A'
    alias gb='git branch'
    alias dc='cd'
    alias la='ls -la'
    alias lls='ls'
  '';

  #TODO: ssh hosts.

  #nix stuff
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc.automatic = true;
  system.autoUpgrade = {
    enable = true;
    flake = "git+https://github.com/adrlau/nix-dotfiles.git";
    flags = [
      "--update-input" "nixpkgs"
      "--update-input" "nixpkgs-unstable"
      "--no-write-lock-file"
    ];
  };
  
}
