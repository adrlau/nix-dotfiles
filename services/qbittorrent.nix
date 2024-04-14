{ config, lib, pkgs, options, ... }:
let
  port = 8090;
  Interface = "tun0";
  InterfaceAddress = "";
  torrentPort = 44183;
  TempPath = "/Main/Data/media/Downloads/temp";
  TorrentExportPath = "/Main/Data/media/Downloads/torrents";
  FinishedTorrentExportDirectory = "/Main/Data/media/Downloads/torrents-complete";
in
{
  imports = [
    ../modules/qbittorrent-nox.nix
  ];

  environment.systemPackages = [
    pkgs.qbittorrent-nox
  ];

  services.qbittorrent-nox = {
    enable = true;
    Interface = Interface;
    openFirewall = true;
    user = "qbittorrent";
    group = "qbittorrent";
    Filelogger = {
      enable = true;
      age = 1;
      ageType = 1;
      backup = true;
      deleteOld = true;
      maxSizeBytes = 66560;
      path = "/Main/Data/media/.qbittorrent/logs";
    };
    MemoryWorkingSetLimit = 8192;
    AddExtensionToIncompleteFiles = true;
    AlternativeGlobalDLSpeedLimit = 1000;
    AlternativeGlobalUPSpeedLimit = 1000;
    AnonymousModeEnabled = false;
    BTProtocol = "Both";
    BandwidthSchedulerEnabled = false;
    DefaultSavePath = TorrentExportPath;
    Encryption = 1;
    ExcludedFileNames = "";
    FinishedTorrentExportDirectory = FinishedTorrentExportDirectory;
    GlobalDLSpeedLimit = 0;
    GlobalMaxRatio = 1.5;
    GlobalUPSpeedLimit = 0;
    I2PEnabled = true;
    IgnoreLimitsOnLAN = true;
    IncludeOverheadInLimits = true;
    InterfaceAddress = InterfaceAddress;
    InterfaceName = Interface;
    LSDEnabled = true;
    MaxActiveCheckingTorrents = 15;
    MaxRatioAction = 1;
    Port = torrentPort;
    Preallocation = true;
    QueueingSystemEnabled = false;
    SubcategoriesEnabled = true;
    Tags = "movie, anime";
    TempPath = TempPath;
    TempPathEnabled = true;
    TorrentExportDirectory = TorrentExportPath;
    UseAlternativeGlobalSpeedLimit = false;
    AutoDeleteAddedTorrentFile = "Never";
    Accepted = true;
    MigrationVersion = 6;
    PortForwardingEnabled = true;
    GeneralLocale = "en";
    MailNotificationReqAuth = true;
    SchedulerDays = "Weekday";
    SchedulerEndTime = "@Variant(\\0\\0\\0\\xf\\x5%q\\xa0)";
    WebUIAuthSubnetWhitelist = "192.168.1.0/24, 100.0.0.0/8";
    WebUIAuthSubnetWhitelistEnabled = true;
    WebUIPort = port;
    WebUIUseUPnP = false;
    AutoDownloaderDownloadRepacks = true;
    AutoDownloaderEnableProcessing = true;
    AutoDownloaderSmartEpisodeFilter = "s(\\d+)e(\\d+), (\\d+)x(\\d+), \"(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})\", \"(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})\"";
    SessionEnableProcessing = true;
  };
}