{ config, pkgs, ... }:
{
  # Arion works with Docker, but for NixOS-based containers, you need Podman
  # since NixOS 21.05.
  virtualisation.docker.enable = false;
  virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true ;
        autoPrune.flags = ["--all"];
        autoPrune.enable = true;
	defaultNetwork.settings = { dns_enabled = true; };
  };

  users.extraUsers.gunalx.extraGroups = ["podman"];
}
