{ lib, config, ... }:

let
  # Path to your source folder of wallpapers
  wallpaperSrc = ./wallpapers;

  # Read all file names in that directory
  names = lib.attrNames (builtins.readDir wallpaperSrc);

  # For each name, produce an attrset mapping
  wallpaperFiles = map (name:
    {
      # quoted string keys are valid attribute names
      "Pictures/wallpapers/${name}" = {
        source = "${wallpaperSrc}/${name}";
      };
    }
  ) names;
in
{
  # Merge them all under home.file
  home.file = lib.mkMerge wallpaperFiles;
}
