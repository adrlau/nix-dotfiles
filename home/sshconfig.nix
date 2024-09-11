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
    extraConfig = "";
  };
}

