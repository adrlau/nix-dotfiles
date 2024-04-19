{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.openssh
    pkgs.endlessh-go
    pkgs.sshguard
  ];

  services.openssh = {
    enable = true;
    settings.UseDns = true;
    settings.PermitRootLogin = "prohibit-password";
    startWhenNeeded = true;
    ports = [ 6969 ];
    openFirewall = true;
    #settings.Ciphers = [
    #  "chacha20-poly1305@openssh.com"
    #  "aes256-gcm@openssh.com"
    #  "aes128-gcm@openssh.com"
    #  "aes256-ctr"
    #  # remove some weaker ciphers
    #];
  };
  services.endlessh-go = {
    enable = true;
    port = 22;
    openFirewall = true;
  };
  services.sshguard.enable = true; #protection against brute force attacks
}
