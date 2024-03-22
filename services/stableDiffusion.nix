{ config, pkgs, lib, ... }:
{
  imports = [
    ./podman.nix
  ];
  environment.systemPackages = [
  ];
  virtualisation.oci-containers.containers."stableDiffusion" = {
    #cmd = ["invokeai-web" "--host" "0.0.0.0"];
    ports = ["9090:9090" "9000:80" ];
    #enviroment = { };
    #image = "invokeai/invokeai";
    image = "goolashe/automatic1111-sd-webui";
  };
}
