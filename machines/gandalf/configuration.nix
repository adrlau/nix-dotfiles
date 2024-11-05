# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../profiles/base.nix
        ../../services/virt.nix
       ./qemu.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = true;                   
  networking.interfaces.wlp3s0f0.useDHCP = true; # Interface is not constant. I really only want to use dhcp att all so could remove this in favor of the old way.
  networking.hostName = "gandalf"; # Define your hostname.
  
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    tailscale
  ];

  users.users.gunalx = { # Define a user account. Don't forget to set a password with ‘passwd’.
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "pw123";  # this is changed imedeately.
  };




  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTExYoT3+flrd2wPYiT7sFFDmAUqi2YAz0ldQg7WMop"
  ];
  users.users."gunalx".openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTExYoT3+flrd2wPYiT7sFFDmAUqi2YAz0ldQg7WMop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEj+Y0RUrSaF8gUW8m2BY6i8e7/0bUWhu8u8KW+AoHDh gunalx@nixos"
  ];

  #firewall options
  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [
      80
      443
      25565
      config.services.tailscale.port
      #config.services.headscale.port
    ];
    allowedTCPPorts = config.networking.firewall.allowedUDPPorts;
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  
}
