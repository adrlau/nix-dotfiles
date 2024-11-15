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
      "*" = {

        identityFile = [
          "~/.ssh/nixos"
          "~/.ssh/id_ed25519"
        ];
      };

      "*.pvv.ntnu.no" = {
        user="adriangl";
      };
      "*.ntnu.no !login.pvv.ntnu.no" = {
        user="adriangl";
        proxyJump="login.pvv.ntnu.no";
      };
      "snotra" = {
        user="adriangl";
        proxyJump="adriangl@login.pvv.ntnu.no";
        hostname="snotra.idi.ntnu.no";
      };

      #pbsds

      "garp.pbsds.net" = {
        user="adrlau";
        proxyJump = "login.pvv.ntnu.no";
        extraOptions = {
          StrictHostKeyChecking = "no";
          UserKnownHostsFile = "/dev/null";
        };
      };
      "bolle.pbsds.net" = {
        user="adrlau";
        proxyJump = "login.pvv.ntnu.no";
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

      "galadriel" = {
        port = 6969;
        user="gunalx";
        hostname="100.84.215.84";
      };
      
      "gandalf" = {
        port = 6969;
        user="gunalx";
        hostname="100.124.183.16";
      };

      "elrond" = {
        port = 6969;
        user="gunalx";
        hostname="100.101.17.39 ";
      };



    };

    extraConfig = "";
  };
}

