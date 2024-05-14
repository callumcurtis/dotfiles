{ stdenv, fetchFromGitHub, fetchurl, lib }:

stdenv.mkDerivation rec {
  name = "poly-dark-grub-theme";

  src = fetchFromGitHub ({
    owner = "shvchk";
    repo = "poly-dark";
    rev = "4850f0c917a0fa320cfd32779b4030baebb2ba8c";
    hash = "sha256-o8dMaXItmmZiOIBnRRYiepPH8bPBR3tjWyALaenXqlM=";
  });

  font = fetchurl {
    url = "https://unifoundry.com/pub/unifont/unifont-15.1.05/font-builds/unifont-15.1.05.otf";
    hash = "sha256-e2K1CsuxhmidwwxEbOQ2e4fXlInpkHuDJV+fvg3PueE=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/

    rm unifont-regular-16.pf2

    cp -r * $out/
    cp ${font} $out/font.otf

    runHook postInstall
  '';

  meta = {
    description = "Poly dark theme for the GRUB bootloader";
    homepage = "https://github.com/shvchk/poly-dark";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}

