{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.codex.enable = lib.mkEnableOption "codex";

  config = lib.mkIf config.dotfiles.features.codex.enable {
    programs.codex = {
      enable = true;
      package = pkgs.unstable.codex;
    };
  };
}
