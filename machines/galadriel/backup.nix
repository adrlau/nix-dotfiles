{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rsync
  ];
  systemd.timers."backupData" = {
  wantedBy = [ "timers.target" ];
  timerConfig = {
      OnCalendar="*-*-* 8:00:00";
      Unit = "backupData.service";
    };
};

systemd.services."backupData" = {
  path = [
        pkgs.rsync
      ];
  script = ''rsync --archive /Data /Main'';
  serviceConfig = {
    Type = "oneshot";
    User = "root";
  };
};
}
