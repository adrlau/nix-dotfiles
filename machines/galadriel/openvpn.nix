{ config, pkgs, lib, ... }:
{
    
    sops.secrets."openvpn/galadriel/config"  = {};
    services.openvpn.servers.galadriel = {
      config = "config ${config.sops.secrets."openvpn/galadriel/config".path}";
    };


}
