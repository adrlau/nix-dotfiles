{ config, lib, pkgs, options, ... }:
let
  port = 8090;
  configLocation = "~/.config/qBittorrent/qBittorrent.conf";
in
{

  environment.systemPackages = [
    pkgs.qbittorrent-nox
  ];
  systemd.services."qbittorrent-nox@" = {
    serviceConfig.ExecStart = let
    in "qbittorrent-nox -d  --webui-port=${port}";
  };


#services.transmission = { 
#    enable = false; #Enable transmission daemon
#    openRPCPort = true; #Open firewall for RPC
#    settings = { #Override default settings
#      rpc-bind-address = "0.0.0.0"; #Bind to own IP
#      rpc-whitelist = "127.0.0.1,192.168.0.0/23,10.0.0.0/23,100.0.0.0/8,100.117.216.131 "; #Whitelist your remote machine (10.0.0.1 in this example)
#    };

};

  

}
