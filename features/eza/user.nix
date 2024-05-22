{ config, lib, ... }:

{
  options.dotfiles.features.eza.enable = lib.mkEnableOption "eza";

  config = lib.mkIf config.dotfiles.features.eza.enable {
    programs.eza = {
      enable = true;
      icons = true;
      git = true;
    };
  };
}
