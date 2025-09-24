{ config, lib, pkgs, ... }:
let
  interfaceaddress = builtins.readFile config.sops.secrets."qbittorrent/interfaceAddress".path;
in
{

  imports = [
    ../profiles/sops.nix
  ];
  

  sops.secrets."qbittorrent/interfaceAddress" = {
    restartUnits = [ "qbittorrent-nox.service" ];
    owner = "qbittorrent";
    mode = "0755";
  };

  users.users.qbittorrent = {
    group = lib.mkForce "media";

  };
  users.groups.qbittorrent = {};



  services.qbittorrent = {
    enable = true;
    extraArgs = [
        "--confirm-legal-notice"
      ];

    webuiPort = 8090;
    torrentingPort = 44183;

    serverConfig = {
      LegalNotice.Accepted = true;
      Meta.MigrationVersion=6;
      Network.PortForwardingEnabled=true;

      Preferences = {
        WebUI = {
          AuthSubnetWhitelist="192.168.1.0/24, 100.0.0.0/8";
          AuthSubnetWhitelistEnabled=true;
          UseUPnP=false;

        };
      BitTorrent = {
        Session = {
          AddExtensionToIncompleteFiles=true;
          AlternativeGlobalDLSpeedLimit=1000;
          AlternativeGlobalUPSpeedLimit=1000;
          AnonymousModeEnabled=false;
          BTProtocol="Both";
          BandwidthSchedulerEnabled=false;
          DefaultSavePath="/Main/Data/media/Downloads";
          Encryption=1;
          FinishedTorrentExportDirectory="/Main/Data/media/Downloads/torrents-complete";
          GlobalDLSpeedLimit=0;
          GlobalMaxRatio=1.5;
          GlobalUPSpeedLimit=0;
          I2P.Enabled=true;
          IgnoreLimitsOnLAN=true;
          IncludeOverheadInLimits=true;
          Interface="tun0";
          #InterfaceAddress="${config.sops.placeholder."qbittorrent/interfaceAddress"}";
          InterfaceAddress="${interfaceaddress}";
          InterfaceName="tun0";
          LSDEnabled="true";
          MaxActiveCheckingTorrents=15;
          MaxRatioAction=1;
          Port=44183;
          Preallocation=true;
          QueueingSystemEnabled=false;
          SubcategoriesEnabled=true;
          Tags="movie, anime";
          TempPath="/Main/Data/media/Downloads/temp";
          TempPathEnabled=true;
          TorrentContentLayout="Subfolder";
          TorrentExportDirectory="/Main/Data/media/Downloads/torrents";
          UseAlternativeGlobalSpeedLimit=false;
        };
      };
    
      RSS = {
        AutoDownloader = {
          DownloadRepacks=true;
          EnableProcessing=true;
          SmartEpisodeFilter="s(\\d+)e(\\d+), (\\d+)x(\\d+), \"(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})\", \"(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})\"";
        };
       Session.EnableProcessing=true;
      };
        General.Locale = "en";
      };

    };


  };


}
