{ config, pkgs, ... }:
{
  services.boinc = { 
    enable = true;
    package = pkgs.boinc-headless;
    extraEnvPackages = with pkgs ;[
      virtualbox
      ocl-icd
    ]; 
  };

}
