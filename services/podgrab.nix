{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.podgrab
  ];
  services.podgrab.enable = true;
  services.podgrab.port = 4242;
  networking.firewall.allowedTCPPorts = [ config.services.podgrab.port ];
}
