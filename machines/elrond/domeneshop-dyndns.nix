{ config, pkgs, lib, ... }:

let
  cfg = config.services.domeneshop-dyndns;
in {
  options.services.domeneshop-dyndns = {
    enable = lib.mkEnableOption "Domeneshop DynDNS";

    domain = lib.mkOption {
      type = lib.types.str;
      description = "Domain name to configure";
    };

    netrcFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to the file that contains `machine api.domeneshop.no login <DDNS_TOKEN> password <DDNS_SECRET>` from https://domene.shop/admin?view=api";
    };

    startAt = lib.mkOption {
      type = lib.types.str;
      default = "*:0/10"; # Every 10 minutes
      description = "Systemd onCalendar expression for when to run the timer";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.domeneshop-dyndns = {
      serviceConfig.LoadCredential = "netrc:${cfg.netrcFile}";
      startAt = cfg.startAt;

      script = ''
        DNSNAME="${cfg.domain}"
        NEW_IP="$(${lib.getExe pkgs.curl} --silent https://ipinfo.io/ip)"
        OLD_IP="$(${lib.getExe pkgs.getent} hosts "$DNSNAME" | ${lib.getExe pkgs.gawk} '{ print $1 }')"

        if [[ "$NEW_IP" != "$OLD_IP" ]]; then
          echo "Old IP ($OLD_IP) does not match new IP ($NEW_IP), updating..."
          ${lib.getExe pkgs.curl} --silent --netrc-file "$CREDENTIALS_DIRECTORY/netrc" "https://api.domeneshop.no/v0/dyndns/update?hostname=$DNSNAME&myip=$NEW_IP"
        else
          echo "Old IP ($OLD_IP) matches new IP ($NEW_IP), exiting..."
        fi
      '';
    };
  };
}

