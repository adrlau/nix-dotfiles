{ config, lib, pkgs, ... }:
let
  port = 8090;
  torrentPort = 44183;
  savePath = "/Main/Data/media/Downloads/";
  path = "/var/lib/qbittorrent";
  #p[-interfaceAddress = pkgs.coreutils + "/bin/cat ${config.sops.secrets."qbittorrent/interfaceAddress".path}";
  #interfaceAddress = "${config.sops.placeholder."qbittorrent/interfaceAddress"}";

  interfaceAddress = "${config.sops.templates."qbittorrent/interfaceAddress".content}";

  contentLayout = "Subfolder";

  configurationFile = pkgs.writeText "qbittorrent.conf" ''
[Application]
FileLogger\Age=1
FileLogger\AgeType=1
FileLogger\Backup=true
FileLogger\DeleteOld=true
FileLogger\Enabled=true
FileLogger\MaxSizeBytes=66560
FileLogger\Path=/Main/Data/media/.qbittorrent/logs
MemoryWorkingSetLimit=8192

[BitTorrent]
Session\AddExtensionToIncompleteFiles=true
Session\AlternativeGlobalDLSpeedLimit=1000
Session\AlternativeGlobalUPSpeedLimit=1000
Session\AnonymousModeEnabled=false
Session\BTProtocol=Both
Session\BandwidthSchedulerEnabled=false
Session\DefaultSavePath=/Main/Data/media/Downloads
Session\Encryption=1
Session\ExcludedFileNames=
Session\FinishedTorrentExportDirectory=/Main/Data/media/Downloads/torrents-complete
Session\GlobalDLSpeedLimit=0
Session\GlobalMaxRatio=1.5
Session\GlobalUPSpeedLimit=0
Session\I2P\Enabled=true
Session\IgnoreLimitsOnLAN=true
Session\IncludeOverheadInLimits=true
Session\Interface=tun0
Session\InterfaceAddress=${interfaceAddress}
Session\InterfaceName=tun0
Session\LSDEnabled=true
Session\MaxActiveCheckingTorrents=15
Session\MaxRatioAction=1
Session\Port=44183
Session\Preallocation=true
Session\QueueingSystemEnabled=false
Session\SubcategoriesEnabled=true
Session\Tags=movie, anime
Session\TempPath=/Main/Data/media/Downloads/temp
Session\TempPathEnabled=true
Session\TorrentContentLayout=${contentLayout}
Session\TorrentExportDirectory=/Main/Data/media/Downloads/torrents
Session\UseAlternativeGlobalSpeedLimit=false

[Core]
AutoDeleteAddedTorrentFile=Never

[LegalNotice]
Accepted=true

[Meta]
MigrationVersion=6

[Network]
PortForwardingEnabled=true

[Preferences]
General\Locale=en
MailNotification\req_auth=true
Scheduler\days=Weekday
Scheduler\end_time=@Variant(\0\0\0\xf\x5%q\xa0)
WebUI\AuthSubnetWhitelist=192.168.1.0/24, 100.0.0.0/8
WebUI\AuthSubnetWhitelistEnabled=true
WebUI\Port=${toString port}
WebUI\UseUPnP=false

[RSS]
AutoDownloader\DownloadRepacks=true
AutoDownloader\EnableProcessing=true
AutoDownloader\SmartEpisodeFilter=s(\\d+)e(\\d+), (\\d+)x(\\d+), "(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})", "(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})"
Session\EnableProcessing=true
'';


in
{

  imports = [
    ../profiles/sops.nix
  ];
  
  networking.firewall.allowedTCPPorts = [ port torrentPort];
  networking.firewall.allowedUDPPorts = [ port torrentPort];

  sops.secrets."qbittorrent/interfaceAddress" = {};

  users.users.qbittorrent = {
    isNormalUser = true; #make this a normal user to be able to make files
    home = path;
    group = "media";
  };
  users.groups.qbittorrent = {};

  systemd.services."qbittorrent-nox" = {
    after = [ "network.target" ];
    wants = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStartPre = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/mkdir -p ${path} && ${pkgs.coreutils}/bin/chmod -R 755 ${path} && ${pkgs.coreutils}/bin/cp ${configurationFile} ${path}/.config/qBittorrent/qBittorrent.conf'";
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
      User = "qbittorrent";
      Group = "media";
      Restart = "on-failure";

      ProtectKernelModules = true;
      NoNewPrivileges = true;
    };

  };
}