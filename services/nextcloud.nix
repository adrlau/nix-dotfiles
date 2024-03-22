{ config, pkgs, lib, ... }:
let
  cfg = config.services.nextcloud;
  hostName = "nextcloud.lauterer.it";
in {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud28;
    inherit hostName;
    home = "/var/lib/nextcloud";
    https = true;
    webfinger = true;

    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      adminuser = "ncadmin";
      adminpassFile = config.sops.secrets."nextcloud/adminpass".path;
      trustedProxies = [ "100.101.17.39" ]; # elrond
      defaultPhoneRegion = "NO";
    };

    phpOptions = {
      "opcache.interned_strings_buffer" = "16";
      "upload_max_filesize" = lib.mkForce "8G";
      "post_max_size" = lib.mkForce "8G";
      "memory_limit" = lib.mkForce "8G";
    };

    poolSettings = {
      "pm" = "ondemand";
      "pm.max_children" = 32;
      "pm.process_idle_timeout" = "10s";
      "pm.max_requests" = 500;
    };
  };

  environment.systemPackages = [ cfg.occ ];

  sops.secrets."nextcloud/adminpass" = {
    mode = "0440";
    owner = "nextcloud";
    group = "nextcloud";
    restartUnits = [ "phpfpm-nextcloud.service" ];
  };

  services.postgresql = {
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [ {
      name = "nextcloud";
      ensureDBOwnership = true;
    } ];
  };

  systemd.services."nextcloud-setup" = {
    requires = [ "postgresq:l.service" ];
    after = [ "postgresql.service" ];
  };

  systemd.services."phpfpm-nextcloud" = {
    requires = [ "var-lib-nextcloud.mount" ];
    serviceConfig = {
      WorkingDirectory = "/var/lib/nextcloud";
      NoNewPrivileges = true;
      PrivateDevices = true;
      PrivateMounts = true;
      PrivateTmp = true;
      ProtectClock = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectProc = "invisible";
      ReadWritePaths = [ "/var/lib/nextcloud" "/run/phpfpm" "/run/systemd" "/run/secrets" "/nix/store" ];
      RemoveIPC = true;
      RestrictSUIDSGID = true;
      UMask = "0007";
      SystemCallArchitectures = "native";
      SystemCallFilter = "@system-service";
      CapabilityBoundingSet = "~CAP_FSETID ~CAP_SETFCAP ~CAP_SETUID ~CAP_SETGID ~CAP_SETPCAP ~CAP_NET_ADMIN ~CAP_SYS_ADMIN ~CAP_SYS_PTRACE ";
    };
  };

  fileSystems."/var/lib/nextcloud" = {
    device = "/tank/nextcloud";
    options = [ "bind "];
  };
}

