{ config, pkgs, lib, ... }:
{
  services.mealie = {
    enable = true;
    settings = {
      ALLOW_SIGNUP = "true";
    };
    database.createLocally = true;
  };

}
