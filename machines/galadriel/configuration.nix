# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
     ./hardware-configuration.nix
     ./vim.nix
     ./nvidia.nix
     ./openvpn.nix
     ../../profiles/base.nix
     ../../profiles/sops.nix
     ./zfs.nix
     ./backup.nix
     ../../services/stableDiffusion.nix
     #../../services/freshrrs.nix 
     #../../services/torrent.nix

   ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true; 


  networking.hostName = "galadriel"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "no";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "no";

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
      tailscale
      jellyfin
      jellyfin-web
      jellyfin-mpv-shim
      jftui
      sonixd
      unpackerr
      qbittorrent-nox
      python310
      python310Packages.torchWithCuda
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
  
##media
  users.groups.media.members = ["jellyfin"]; #have media directory owned by media group
  services.jellyfin.group = "media"; 
  services.jellyfin.enable = true;


#  services.komga.enable = true;
  
  #services.polaris.enable = true;
  #services.navidrome.enable = true;
  
  #services.podgrab.enable = true;
  #services.podgrab.port = 4242;
  
  #services.calibre-web.enable = true;
  #services.calibre-server.enable = true;

##networking
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  #tailscale
  services.tailscale.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

##storage

  
  #autofs
  #services.autofs.enable = true;

  #smb share
  
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
