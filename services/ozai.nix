{ config, pkgs, lib, ... }:
{

  services.ozai.enable = true;
  services.ozai.host = "0.0.0.0";
  services.ozai.port = 8000;

  services.ozai-webui = {
    enable = true;
    port = 8085;
    host = "0.0.0.0";
  };

}
