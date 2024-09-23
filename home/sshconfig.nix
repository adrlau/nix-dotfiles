{ pkgs, lib, config, ... }:
{
  imports = [
  ];

  home.packages = with pkgs; [
    openssh
    sshfs
  ];
  
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    compression = true;

    matchBlocks = {
      "*.pvv.ntnu.no" = {
        user="adriangl";
      };
      "*.ntnu.no !*.pvv.ntnu.no" = {
        user="adriangl";
        proxyJump="isvegg.pvv.ntnu.no";
      };
      "snotra" = {
        user="adriangl";
        proxyJump="adriangl@isvegg.pvv.ntnu.no";
        hostname="snotra.idi.ntnu.no";
      };

      #pvv
      "pvv" = {
        user="adriangl";
        hostname="login.pvv.ntnu.no";
      };
      "isvegg" = {
        user="adriangl";
        hostname="isvegg.pvv.ntnu.no";
      };

      #home
      "aragon" = {
        port = 6969;
        user="gunalx";
        hostname="100.74.34.149";

      };



    };

    extraConfig = "";
  };
}

