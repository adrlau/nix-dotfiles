{ stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "wallpapers";
  version = "1.0";

  src = ./;

  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r * $out/share/wallpapers/
  '';

  meta = with lib; {
    description = "My Collection of wallpapers";
    license = licenses.unfree;
    maintainers = with maintainers; [ adriangl ];
  };
}
