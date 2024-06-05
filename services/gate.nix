{ config, lib, pkgs, ... }:
let
  mcPort = 25565;
  configurationFile = ''
    config:
      lite:
        enabled: true
        routes:
          - host: mc.256.no
            backend: 100.84.215.84:25565
    '';
  file = pkgs.writeText "gate.yaml" configurationFile;
in
{
  
  networking.firewall.allowedTCPPorts = [ mcPort];
  networking.firewall.allowedUDPPorts = [ mcPort];

  users.users.gate = {
    isSystemUser = true;
    description = "Gate Minecraft Proxy User";
    home = "/var/lib/gate";
    createHome = true;
    group = "gate";
  };

  users.groups.gate = {
  };

  systemd.services."gate" = {
    after = [ "network.target" ];
    wants = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.gate}/bin/gate -c ${file}";
      User = "gate";
      Group = "gate";
      Restart = "on-failure";
      ProtectKernelModules = true;
      NoNewPrivileges = true;
    };
  };
}
