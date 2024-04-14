{ config, lib, pkgs, options, ... }:
let
  port = 8090;
  torrentPort = 44183;
  savePath = "/Main/Data/media/Downloads/";
  path = "/var/lib/qbittorrent";
in
{
  networking.firewall.allowedTCPPorts = [ port torrentPort];
  networking.firewall.allowedUDPPorts = [ port torrentPort];

  users.users.qbittorrent = {
    isNormalUser = true; #make this a normal user to be able to make files
    home = path;
    group = "qbittorrent";
  };
  users.groups.qbittorrent = {};

  systemd.services."qbittorrent-nox" ={
    after = [ "network.target" ];
    #environment.HOME = "/var/lib/qbittorrent";

    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${path}";
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=${toString port} --torrenting-port=${toString torrentPort} --save-path=${savePath}";
      User = "qbittorrent";
      Group = "qbittorrent";
      Restart = "on-failure";

      #DynamicUser = true;
      #RuntimeDirectory = "qbittorrent";
      #InaccessiblePaths = [ "/home" "/root" "/run" "/boot" "/etc" "/proc" "/sys" "/usr" "/lib" "/bin" "/sbin" "/srv" "/opt" ];
      
      # Security options
      #PrivateTmp = true;
      #ProtectSystem = "full";
      #ProtectKernelTunables = true;
      #ProtectKernelModules = true;
      #ProtectControlGroups = true;
      #NoNewPrivileges = true;
      #ProtectHome = true;
      #PrivateDevices = true;
    };
  };
}