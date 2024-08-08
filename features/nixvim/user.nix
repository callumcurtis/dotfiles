{ config, lib, nixvim, ... }:

{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  options.dotfiles.features.nixvim.enable = lib.mkEnableOption "nixvim";

  config = lib.mkIf config.dotfiles.features.nixvim.enable {
    programs.nixvim.enable = true;
  };
}
