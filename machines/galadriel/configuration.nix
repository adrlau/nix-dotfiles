# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./zfs.nix
      ./nvidia.nix
      ./openvpn.nix
      ./backup.nix

      ../../profiles/base.nix
      ../../profiles/sops.nix
      ../../profiles/ai.nix
      ../../profiles/mediaserver.nix

      ../../services/smb.nix
      ../../services/wordpress.nix
      ../../services/torrent.nix
      ../../services/mc.nix
      #../../services/ozai.nix
      #../../services/stableDiffusion.nix
      ../../services/rss.nix
      ../../services/shiori.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  
  networking.hostName = "galadriel"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;



  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gunalx = {
    isNormalUser = true;
    description = "gunalx";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      git
      rsync
      zfs
      tailscale
      nfs-utils
      cifs-utils
      jftui
      sonixd
      unpackerr
      qbittorrent-nox
      python3
      python3Packages.torchWithCuda
      ollama
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

##productivity
  #services.tandoor-recipes.enable = true;
  
#  services.komga.enable = true;
  
  #services.polaris.enable = true;
  #services.navidrome.enable = true;
    
  #services.calibre-web.enable = true;
  #services.calibre-server.enable = true;

##networking
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 8090 8096 443 433 6969 1194 445 139];
  networking.firewall.allowedUDPPorts = [ 22 80 8090 8096 443 433 6969 1194 137 138];
  networking.firewall.enable = true;

##storage

  
  #autofs
  #services.autofs.enable = true;
  
  #nfs share
  #services.nfs.server = {
  #  enable = true;
  #  # fixed rpc.statd port; for firewall
  #  lockdPort = 4001;
  #  mountdPort = 4002;
  #  statdPort = 4000;
  #  extraNfsdConfig = '''';
  #};


  #zfs stuff if needed

  
  #mounts
  # fileSystems."/mnt/nas" = {
  #   device = "192.168.1.137:/mnt/Main/Home";
  #   fsType = "nfs";
    
  #   options = [ 
  #     #"nfsvers=4.2" 
  #     "x-systemd.automount" "noauto"
  #     "x-systemd.idle-timeout=600"
  #     ];
  # };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?





}
