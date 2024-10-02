{ config, lib, ... }:

{
  config = lib.mkIf config.dotfiles.features.nixvim.enable {
    programs.nixvim.colorschemes.catppuccin.enable = true;
  };
}

