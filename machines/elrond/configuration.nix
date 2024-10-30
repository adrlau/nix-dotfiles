# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../profiles/webhost.nix
      ../../profiles/base.nix
      ../../services/gate.nix
      #../../services/ozai.nix
      ./routes.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = true;                   
 # networking.interfaces.ens3.useDHCP = true; # Interface is not constant. I really only want to use dhcp att all so could remove this in favor of the old way.
  networking.hostName = "elrond"; # Define your hostname.
  
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
    config.services.headscale.package
    kanidm
  ];

  users.users.gunalx = { # Define a user account. Don't forget to set a password with ‘passwd’.
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "pw123";  # this is changed imedeately.
  };


#sequrity managment through kanidm
#  systemd.services.kanidm = let
#    certName = config.services.nginx.virtualHosts.${config.services.kanidm.serverSettings.domain}.useACMEHost;
#  in {
#    requires = [ "acme-finished-${certName}.target" ];
#    serviceConfig.LoadCredential = let
#      certDir = config.security.acme.certs.${certName}.directory;
#    in [
#      "fullchain.pem:${certDir}/fullchain.pem"
#      "key.pem:${certDir}/key.pem"
#    ];
#  };
#
#  services.kanidm = {
#    enableServer = true;
#    #enablePam = true;
#    serverSettings = let
#      credsDir = "/run/credentials/kanidm.service";
#      #credsDir = "/var/lib/acme/${config.networking.domain}"; #the files are here but not readable
#    in {
#      origin = "https://${config.services.kanidm.serverSettings.domain}";
#      domain = "auth.${config.networking.domain}";
#      tls_chain = "${credsDir}/fullchain.pem";
#      tls_key = "${credsDir}/key.pem";
#      bindaddress = "localhost:8300";
#    };
#
#    clientSettings = {
#      # This should be at /etc/kanidm/config or ~/.config/kanidm, and configures the kanidm command line tool
#      uri = "${config.services.kanidm.serverSettings.bindaddress}";
#      verify_ca = true;
#      verify_hostnames = true;
#    };
			#  };
#
#  #environment = {
#  #  etc."kanidm/config".text = ''
#  #    uri="https://auth.${config.networking.domain}"
#  #  '';
#  #}; 


#vpn stuff
#  #need to run at fresh install to create namespace: headscale namespaces create <namespace_name> 
#  services.headscale = {
#    enable = true;
#    user = "headscale";
#    address = "127.0.0.1";
#	    port = 8080;
#    settings = {
#      logtail.enabled = false;
#      metrics_listen_addr = "127.0.0.1:9090";
#      server_url = "https://${"vpn."+config.networking.domain}";
#      dns_config = {
#        base_domain = "${config.networking.domain}";
#        magic_dns = true;
#        nameservers = [
#          "1.1.1.1"
#        ];
#      };
#
#      ##should really implement with fex github and kanidm
#      #oidc = {
#      #  issuer  = "{config.services.kanidm.serverSettings.origin}";
#      #  allowed_domains = Domains;
#      #};
#    };
#  };

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
  system.stateVersion = "23.05"; # Did you read the comment?
  
}
