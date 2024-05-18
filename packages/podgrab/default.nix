{ lib, fetchFromGitHub, buildGoModule, nixosTests }:

buildGoModule rec {
  pname = "podgrab";
  version = "unstable-2022-09-20";

  src = fetchFromGitHub {
    owner = "akhilrex";
    repo = pname;
    rev = "44e2b1c207288bb8a84ecb64424e0a501fa02510";
    sha256 = "";
  };

  vendorHash = "sha256-xY9xNuJhkWPgtqA/FBVIp7GuWOv+3nrz6l3vaZVLlIE=";

  postInstall = ''
    mkdir -p $out/share/
    cp -r $src/client $out/share/
    cp -r $src/webassets $out/share/
  '';

  passthru.tests = { inherit (nixosTests) podgrab; };

  meta = with lib; {
    description = "A self-hosted podcast manager to download episodes as soon as they become live";
    mainProgram = "podgrab";
    homepage = "https://github.com/akhilrex/podgrab";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ambroisie ];
  };
}
