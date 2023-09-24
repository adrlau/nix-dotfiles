{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.openssh
    pkgs.endlessh
    pkgs.sshguard
  ];

  services.openssh = {
    enable = true;
    settings.UseDns = true;
    settings.PermitRootLogin = "prohibit-password";
    startWhenNeeded = true;
    UseDns = true;
    ports = [ 25264 ];
    openFirewall = true;
    Ciphers = [
      "chacha20-poly1305@openssh.com"
      "aes256-gcm@openssh.com"
      "aes128-gcm@openssh.com"
      "aes256-ctr"
      # remove some weaker ciphers
    ]
  }
  endlessh = {
    enable = true;
    port = 22;
    openFirewall = true;
  };
  sshguard.enable = true; #protection against brute force attacks like fail2ban


}