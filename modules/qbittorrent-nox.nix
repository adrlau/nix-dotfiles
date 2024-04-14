{ config, lib, pkgs, options, ... }:

let
  cfg = config.services.qbittorrent-nox;
  path = "/var/lib/qbittorrent";
  cfgPath = "${path}/.config/qBittorrent/qBittorrent.conf";

  configurationFile = pkgs.writeText "qbittorrent-nox.conf" ''
    [Application]
    FileLogger\Age=${toString cfg.Filelogger.age}
    FileLogger\AgeType=${toString cfg.Filelogger.ageType}
    FileLogger\Backup=${toString cfg.Filelogger.backup}
    FileLogger\DeleteOld=${toString cfg.Filelogger.deleteOld}
    FileLogger\Enabled=${toString cfg.Filelogger.enable}
    FileLogger\MaxSizeBytes=${toString cfg.Filelogger.maxSizeBytes}
    FileLogger\Path=${cfg.Filelogger.path}
    MemoryWorkingSetLimit=${toString cfg.MemoryWorkingSetLimit}

    [BitTorrent]
    Session\AddExtensionToIncompleteFiles=${toString cfg.AddExtensionToIncompleteFiles}
    Session\AlternativeGlobalDLSpeedLimit=${toString cfg.AlternativeGlobalDLSpeedLimit}
    Session\AlternativeGlobalUPSpeedLimit=${toString cfg.AlternativeGlobalUPSpeedLimit}
    Session\AnonymousModeEnabled=${toString cfg.AnonymousModeEnabled}
    Session\BTProtocol=${cfg.BTProtocol}
    Session\BandwidthSchedulerEnabled=${toString cfg.BandwidthSchedulerEnabled}
    Session\DefaultSavePath=${cfg.DefaultSavePath}
    Session\Encryption=${toString cfg.Encryption }
    Session\ExcludedFileNames=${cfg.ExcludedFileNames}
    Session\FinishedTorrentExportDirectory=${cfg.FinishedTorrentExportDirectory}
    Session\GlobalDLSpeedLimit=${toString cfg.GlobalDLSpeedLimit}
    Session\GlobalMaxRatio=${toString cfg.GlobalMaxRatio}
    Session\GlobalUPSpeedLimit=${toString cfg.GlobalUPSpeedLimit}
    Session\I2P\Enabled=${toString cfg.I2PEnabled}
    Session\IgnoreLimitsOnLAN=${toString cfg.IgnoreLimitsOnLAN}
    Session\IncludeOverheadInLimits=${toString cfg.IncludeOverheadInLimits}
    Session\Interface=${cfg.Interface}
    Session\InterfaceAddress=${cfg.InterfaceAddress}
    Session\InterfaceName=${cfg.InterfaceName}
    Session\LSDEnabled=${toString cfg.LSDEnabled}
    Session\MaxActiveCheckingTorrents=${toString cfg.MaxActiveCheckingTorrents}
    Session\MaxRatioAction=${toString cfg.MaxRatioAction}
    Session\Port=${toString cfg.Port}
    Session\Preallocation=${toString cfg.Preallocation}
    Session\QueueingSystemEnabled=${toString cfg.QueueingSystemEnabled}
    Session\SubcategoriesEnabled=${toString cfg.SubcategoriesEnabled}
    Session\Tags=${cfg.Tags}
    Session\TempPath=${cfg.TempPath}
    Session\TempPathEnabled=${toString cfg.TempPathEnabled}
    Session\TorrentExportDirectory=${cfg.TorrentExportDirectory}
    Session\UseAlternativeGlobalSpeedLimit=${toString cfg.UseAlternativeGlobalSpeedLimit}

    [Core]
    AutoDeleteAddedTorrentFile=${cfg.AutoDeleteAddedTorrentFile}

    [LegalNotice]
    Accepted=${toString cfg.Accepted}

    [Meta]
    MigrationVersion=${toString cfg.MigrationVersion}

    [Network]
    PortForwardingEnabled=${toString cfg.PortForwardingEnabled}

    [Preferences]
    General\Locale=${cfg.GeneralLocale}
    MailNotification\req_auth=${toString cfg.MailNotificationReqAuth}
    Scheduler\days=${cfg.SchedulerDays}
    Scheduler\end_time=${cfg.SchedulerEndTime}
    WebUI\AuthSubnetWhitelist=${cfg.WebUIAuthSubnetWhitelist}
    WebUI\AuthSubnetWhitelistEnabled=${toString cfg.WebUIAuthSubnetWhitelistEnabled}
    WebUI\Port=${toString cfg.WebUIPort}
    WebUI\UseUPnP=${toString cfg.WebUIUseUPnP}

    [RSS]
    AutoDownloader\DownloadRepacks=${toString cfg.AutoDownloaderDownloadRepacks}
    AutoDownloader\EnableProcessing=${toString cfg.AutoDownloaderEnableProcessing}
    AutoDownloader\SmartEpisodeFilter=${cfg.AutoDownloaderSmartEpisodeFilter}
    Session\EnableProcessing=${toString cfg.SessionEnableProcessing}
  '';
in
{
  options.services.qbittorrent-nox = {
    enable = lib.mkEnableOption {
      default = false;
      description = "Enable qbittorrent-nox service.";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to open the qbittorrent-nox port in the firewall.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "qbittorrent";
      description = "User to run qbittorrent-nox as.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "qbittorrent";
      description = "Group to run qbittorrent-nox as.";
    };

    # FileLogger
    Filelogger.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable the file logger.";
    };
    Filelogger.age = lib.mkOption {
      type = lib.types.int;
      default = 1;
      description = "Age of the log file.";
    };
    Filelogger.ageType = lib.mkOption {
      type = lib.types.int;
      default = 1;
      description = "Age type of the log file.";
    };
    Filelogger.backup = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to backup the log file.";
    };
    Filelogger.deleteOld = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to delete old log files.";
    };
    Filelogger.maxSizeBytes = lib.mkOption {
      type = lib.types.int;
      default = 66560;
      description = "Max size of the log file in bytes.";
    };
    Filelogger.path = lib.mkOption {
      type = lib.types.str;
      default = "${path}/.qbittorrent/logs";
      description = "Path to the log file.";
    };
    
    MemoryWorkingSetLimit = lib.mkOption {
      type = lib.types.int;
      default = 8192;
      description = "Memory working set limit.";
    };

    # BitTorrent
    AddExtensionToIncompleteFiles = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Add extension to incomplete files.";
    };

    AlternativeGlobalDLSpeedLimit = lib.mkOption {
      type = lib.types.int;
      default = 1000;
      description = "Alternative global download speed limit.";
    };

    AlternativeGlobalUPSpeedLimit = lib.mkOption {
      type = lib.types.int;
      default = 1000;
      description = "Alternative global upload speed limit.";
    };

    AnonymousModeEnabled = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable anonymous mode.";
    };

    BTProtocol = lib.mkOption {
      type = lib.types.str;
      default = "Both";
      description = "BitTorrent protocol.";
    };

    BandwidthSchedulerEnabled = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable bandwidth scheduler.";
    };

    DefaultSavePath = lib.mkOption {
      type = lib.types.str;
      default = "${path}";
      description = "Default save path.";
    };

    Encryption = lib.mkOption {
      type = lib.types.int;
      default = 1;
      example = "0";
      description = "Enable encryption.";
    };

    ExcludedFileNames = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Excluded file names.";
    };

    FinishedTorrentExportDirectory = lib.mkOption {
      type = lib.types.str;
      default = "${path}";
      description = "Finished torrent export directory.";
    };
    
    GlobalDLSpeedLimit = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Global download speed limit.";
    };

    GlobalMaxRatio = lib.mkOption {
      type = lib.types.float;
      default = 0;
      description = "Global max ratio.";
    };

    GlobalUPSpeedLimit = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Global upload speed limit.";
    };

    I2PEnabled = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable I2P.";
    };

    IgnoreLimitsOnLAN = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Ignore limits on LAN.";
    };

    IncludeOverheadInLimits = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Include overhead in limits.";
    };

    Interface = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "tun0";
      description = "Interface.";
    };

    InterfaceAddress = lib.mkOption {
      type = lib.types.str;
      example = "";
      default = "10.0.0.0";
      description = "Interface address.";
    };

    InterfaceName = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "tun0";
      description = "Interface name.";
    };

    LSDEnabled = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable LSD.";
    };

    MaxActiveCheckingTorrents = lib.mkOption {
      type = lib.types.int;
      default = 15;
      description = "Max active checking torrents.";
    };

    MaxRatioAction = lib.mkOption {
      type = lib.types.int;
      default = 1;
      description = "Max ratio action.";
    };

    Port = lib.mkOption {
      type = lib.types.int;
      default = 4132;
      description = "Port for bittorrent";
    };

    Preallocation = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Preallocation of storage.";
    };

    QueueingSystemEnabled = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable queueing system.";
    };

    SubcategoriesEnabled = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable subcategories.";
    };

    Tags = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Tags";
    };

    TempPath = lib.mkOption {
      type = lib.types.str;
      default = "${path}/temp";
      description = "Temporary path.";
    };

    TempPathEnabled = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable temporary path.";
    };

    TorrentExportDirectory = lib.mkOption {
      type = lib.types.str;
      default = "${path}/torrents";
      description = "Torrent export directory.";
    };

    UseAlternativeGlobalSpeedLimit = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use alternative global speed limit.";
    };

    # Core
    AutoDeleteAddedTorrentFile = lib.mkOption {
      type = lib.types.str;
      default = "Never";
      description = "Auto delete added torrent file.";
    };

    # LegalNotice
    Accepted = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Accepted legal notice.";
    };

    # Meta
    MigrationVersion = lib.mkOption {
      type = lib.types.int;
      default = 6;
      description = "Migration version.";
    };

    # Network
    PortForwardingEnabled = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable port forwarding.";
    };

    # Preferences
    GeneralLocale = lib.mkOption {
      type = lib.types.str;
      default = "en";
      description = "General locale.";
    };

    MailNotificationReqAuth = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Mail notification requires authentication.";
    };

    SchedulerDays = lib.mkOption {
      type = lib.types.str;
      default = "Weekday";
      description = "Scheduler days.";
    };

    SchedulerEndTime = lib.mkOption {
      type = lib.types.str;
      default = "@Variant(\\0\\0\\0\\xf\\x5%q\\xa0)";
      description = "Scheduler end time.";
    };

    WebUIAuthSubnetWhitelist = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "192.168.1.0/24, 10.0.0.0/24";
      description = "WebUI auth subnet whitelist.";
    };

    WebUIAuthSubnetWhitelistEnabled = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "WebUI auth subnet whitelist enabled.";
    };

    WebUIPort = lib.mkOption {
      type = lib.types.int;
      default = 8080;
      description = "WebUI port.";
    };

    WebUIUseUPnP = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "WebUI use UPnP.";
    };

    # RSS
    AutoDownloaderDownloadRepacks = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Auto downloader download repacks.";
    };

    AutoDownloaderEnableProcessing = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Auto downloader enable processing.";
    };

    AutoDownloaderSmartEpisodeFilter = lib.mkOption {
      type = lib.types.str;
      default = "s(\\d+)e(\\d+), (\\d+)x(\\d+), \"(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})\", \"(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})\"";
      example = "s(\\d+)e(\\d+), (\\d+)x(\\d+), \"(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})\", \"(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})\"";
      description = "Auto downloader smart episode filter.";
    };

    SessionEnableProcessing = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "RSS Session enable processing.";
    };
    
  };

  config = lib.mkIf cfg.enable {

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ cfg.Port cfg.WebUIPort ];
    networking.firewall.allowedUDPPorts = lib.mkIf cfg.openFirewall [ cfg.Port cfg.WebUIPort];

    users.users = lib.mkIf (cfg.user == "qbittorrent") {
      qbittorrent = {
        isNormalUser = true;
        home = path;
        group = cfg.group;
      };
    };
    users.groups = lib.mkIf (cfg.group == "qbittorrent") {
      qbittorrent = {};
    };

    systemd.services."qbittorrent-nox" ={
      serviceConfig = {
        #create the configuration file from string using echo
        ExecStartPre = "${pkgs.coreutils}/bin/cat ${configurationFile}";
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --configuration=${configurationFile}";
        User = cfg.user;
        Group = cfg.group;
        Restart = "on-failure";

        # Security options
        PrivateTmp = true;
        ProtectSystem = "full";
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
      };
    };

  };
}