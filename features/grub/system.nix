{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.grub.enable = lib.mkEnableOption "grub";

  config = lib.mkIf config.dotfiles.features.grub.enable {
    # TODO(#1): use stylix to style grub.

    nixpkgs.overlays = [
      (final: prev: {
        poly-dark-grub-theme = final.stdenv.mkDerivation rec {
          name = "poly-dark-grub-theme";

          src = final.fetchFromGitHub ({
            owner = "shvchk";
            repo = "poly-dark";
            rev = "4850f0c917a0fa320cfd32779b4030baebb2ba8c";
            hash = "sha256-o8dMaXItmmZiOIBnRRYiepPH8bPBR3tjWyALaenXqlM=";
          });

          font = final.fetchurl {
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
            license = final.lib.licenses.mit;
            platforms = final.lib.platforms.linux;
          };
        };
      })
    ];

    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        theme = pkgs.poly-dark-grub-theme;
        font = "${pkgs.poly-dark-grub-theme}/font.otf";
        fontSize = 48;
      };
    };
  };
}
