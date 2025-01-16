{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.open-webui
    pkgs.gvisor

  ];


  services.open-webui = {
    enable = true;

    package = pkgs.unstable.open-webui;
    port = 11111;
    host = "0.0.0.0";
    openFirewall = true;

  };
}
