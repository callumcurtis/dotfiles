{ config, lib, ... }:

{
  config = lib.mkIf config.dotfiles.features.nixvim.enable {
    programs.nixvim.globals = {
      mapleader = " ";
    };
  };
}
