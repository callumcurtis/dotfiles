{ config, lib, ... }:

{
  options.dotfiles.features.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf config.dotfiles.features.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
