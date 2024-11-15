{ config, pkgs, lib, ... }:
{
imports =
    [ 
      ../packages/vim.nix
      ../services/ssh.nix
      ./sops.nix
    ];

  environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      git
      unzip
      zip
      gnutar
      wget
      rsync
      ripgrep
      neofetch
      htop
      bottom
      killall
      foot.terminfo
      tailscale
      sops
    ];

  #just allow unfree, im fine with it. 
  nixpkgs.config.allowUnfree = true; 
  
  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };


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
  networking.firewall.interfaces."tailscale0" = let
	    all = { from = 0; to = 65535; };
	  in {
	    allowedUDPPortRanges = [ all ];
	    allowedTCPPortRanges = [ all ];
  };


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

  
  ## some insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "python3.11-youtube-dl-2021.12.17"
  ];
  

  sops.secrets."github/api" = {  
    mode = "0444";
    group = "root";
  };

  #nix stuff
  nix.gc.automatic = true;
  nix = {
    extraOptions = ''
	    builders-use-substitutes = true
	    experimental-features = nix-command flakes impure-derivations ca-derivations
      !include ${config.sops.secrets."github/api".path}
    '';
    
  settings = {
    trusted-users = [ "gunalx" "root" ];
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
        "https://cache.nixos.org/"
        "https://cuda-maintainers.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixos-rocm.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
      ];

    trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="      
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixos-rocm.cachix.org-1:VEpsf7pRIijjd8csKjFNBGzkBqOmw8H9PRmgAq14LnE="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      ];

  };

  buildMachines = [
	#    { hostName = "bob.pvv.ntnu.no";
	#      system = "x86_64-linux";
	#      maxJobs = 12;
	#      supportedFeatures = [ "big-parallel" ];
	#      speedFactor = 129270;
	#    }
	    { hostName = "bolle.pbsds.net";
	      system = "x86_64-linux";
	      maxJobs = 6;
	      speedFactor = 12857;
	    }
	    { hostName = "garp.pbsds.net";
	      system = "x86_64-linux";
	      maxJobs = 4;
	      # i7-6700
	      speedFactor = 8088;
	    }
	    { hostName = "aragon";
	      system = "x86_64-linux";
	      # if the builder supports building for multiple architectures, 
	      # replace the previous line by, e.g.,
	      # systems = ["x86_64-linux" "aarch64-linux"];
	      maxJobs = 6;
	      #speedFactor = 13199;
	      speedFactor = 6000;
	      supportedFeatures = [ ];
	      mandatoryFeatures = [ ];
	    }
	    { hostName = "galadriel";
	      system = "x86_64-linux";
	      maxJobs = 4;
	      #speedFactor = 8066;
	      speedFactor = 4000;
	      supportedFeatures = [ "cuda" ];
	      mandatoryFeatures = [ ];
	    }
	    # {
	    #   hostName = "isvegg.pvv.ntnu.no";
	    #   system = "x86_64-linux";
	    #   maxJobs = 4;
	    #   speedFactor = 4961;
	    #   supportedFeatures = [ "big-parallel" ];
	    #   mandatoryFeatures = [ ];
	    # }
	  ];
    distributedBuilds = true;
  };
    

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
