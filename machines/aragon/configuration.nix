# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ 	# Include the results of the hardware scan.
	./hardware-configuration.nix
        
        
        #profiles
	../../profiles/base.nix
	../../profiles/desktop.nix
  
	
	#home manager
	#../../home/home.nix

	#customised applications
	../../services/podman.nix
	../../services/boinc.nix
	../../services/ollama-amd.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-08650b6b-6143-4503-8bf5-a3d32ef62d73".device = "/dev/disk/by-uuid/08650b6b-6143-4503-8bf5-a3d32ef62d73";
  boot.initrd.luks.devices."luks-08650b6b-6143-4503-8bf5-a3d32ef62d73".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "aragon"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
                "python3.11-youtube-dl-2021.12.17"
              ];


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gunalx = {
    isNormalUser = true;
    description = "Adrian Gunnar Lauterer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #basics
    vim
    git
    wget

    #sleep
    pmutils
    
    
    # When nixos bad
    docker-compose 
    appimage-run
    steam-run
    xwayland-run

    

    #basic programming
    kate
    vscode-fhs
    gcc
    gpp
    gdb
    cmake
    rustup
    rustc
    cargo
    python3
    python3Packages.scipy
    python3Packages.sympy
    python3Packages.numpy
    python3Packages.matplotlib
    #python3Packages.torch
    #python3Packages.torchvision
    #python3Packages.torchWithRocm
    
    rocmPackages.hipcc
    rocmPackages.half
    rocmPackages.hipify
    rocmPackages.rocm-smi
        
    firefox
    ollama
    rpi-imager
    prismlauncher
    #cura #seems broken dependencies.
    prusa-slicer
    openscad

  ];

  hardware.bluetooth.enable = true; 
  services.blueman.enable=true;

  services.tailscale.enable = true;

  # fileSystems."/mnt/nas" = {
  #   device = "truenas:/mnt/Main";
  #   fsType = "nfs";
  #   options = [ "x-systemd.automount" "noauto" ];
  # };

  
  # sleep wakeup rules
  services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
    '';
  
  #comment out to enable sleep. Uncommented over vacations
  #  systemd.targets.sleep.enable = false;
  #   systemd.targets.suspend.enable = false;
  #   systemd.targets.hibernate.enable = false;
  #   systemd.targets.hybrid-sleep.enable = false;
  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
