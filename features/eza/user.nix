{ config, lib, ... }:

{
  options.dotfiles.features.eza.enable = lib.mkEnableOption "eza";

  config = lib.mkIf config.dotfiles.features.eza.enable {
    programs.eza = {
      enable = true;
      # TODO: use standard icons across dotfiles
      icons = true;
      git = true;
    };
  };
}
