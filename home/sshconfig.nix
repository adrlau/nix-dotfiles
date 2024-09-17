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
      "*.ntnu.no !*.pvv.ntnu.no" = {
        user="adriangl";
        proxyJump="isvegg.pvv.ntnu.no";
      };
      "snotra" = {
        user="adriangl";
        proxyJump="isvegg.pvv.ntnu.no";
        host="snotra.idi.ntnu.no";
      };

      #pvv
      "pvv" = {
        user="adriangl";
        host="login.pvv.ntnu.no";
        match="pvv";
      };
      "isvegg" = {
        user="adriangl";
        host="isvegg.pvv.ntnu.no";
      };

      #home
      "aragon" = {
        port = 6969;
        user="gunalx";
        host = "100.74.34.149";

      };



    };

    extraConfig = "";
  };
}

