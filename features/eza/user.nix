{ config, lib, ... }:

{
  options.dotfiles.features.eza.enable = lib.mkEnableOption "eza";

  config = {
    programs.eza = {
      enable = config.dotfiles.features.eza.enable;
      icons = true;
      git = true;
    };
  };
}
