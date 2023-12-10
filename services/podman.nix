{ config, pkgs, ... }:
{
  # Arion works with Docker, but for NixOS-based containers, you need Podman
  # since NixOS 21.05.
  virtualisation.docker.enable = false;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.dnsname.enable = true;

  # Use your username instead of `myuser`
  users.extraUsers.gunalx.extraGroups = ["podman"];
}