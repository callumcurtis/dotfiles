{ config, lib, pkgs, dotfiles, ... }:

let
  metarepo = pkgs.writeShellScriptBin "metarepo" ''
    exec ${dotfiles.metarepo.apps.${pkgs.stdenv.hostPlatform.system}.metarepo.program} "$@"
  '';
in
{
  options.dotfiles.features.metarepo.enable = lib.mkEnableOption "metarepo";

  config = lib.mkIf config.dotfiles.features.metarepo.enable {
    home.packages = [
      metarepo
    ];
  };
}
