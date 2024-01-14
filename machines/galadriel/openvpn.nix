{ config, pkgs, lib, ... }:
{

  imports = [
    ../../profiles/sops.nix
  ];
    
  sops.secrets."openvpn/galadriel/ca"  = {};
  sops.secrets."openvpn/galadriel/cert"  = {};
  sops.secrets."openvpn/galadriel/userkey"  = {};
  sops.secrets."openvpn/galadriel/tlscrypt"  = {};

    services.openvpn.servers = {
      client = {
        config = ''
          client
          dev tun
          remote 134.19.179.141 443
          resolv-retry infinite
          nobind
          persist-key
          persist-tun
          auth-nocache
          verb 3
          explicit-exit-notify 5
          push-peer-info
          setenv UV_IPV6 yes
          ca "${config.sops.secrets."openvpn/galadriel/ca".path}"
          cert "${config.sops.secrets."openvpn/galadriel/cert".path}"
          key "${config.sops.secrets."openvpn/galadriel/userkey".path}"
          remote-cert-tls server
          comp-lzo no
          data-ciphers AES-256-GCM:AES-256-CBC:AES-192-GCM:AES-192-CBC:AES-128-GCM:AES-128-CBC
          data-ciphers-fallback AES-256-CBC
          proto udp
          tls-crypt "${config.sops.secrets."openvpn/galadriel/tlscrypt".path}"
          auth SHA512
        '';
        up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
        down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
      };
    };   

}
