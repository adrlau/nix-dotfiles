{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.freshrss
  ];
  services.freshrss.enable = true;
  services.freshrss.baseUrl = "http://0.0.0.1";
  services.freshrss.passwordFile = config.sops.secrets."freshrss".path; #"/run/secrets/freshrss";

}