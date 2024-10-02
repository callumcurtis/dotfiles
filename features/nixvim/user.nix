{ config, lib, nixvim, ... }:

{
  imports = [
    nixvim.homeManagerModules.nixvim
    ./configuration/colorscheme.nix
    ./configuration/globals.nix
    ./configuration/keymaps.nix
    ./configuration/options.nix
  ];

  options.dotfiles.features.nixvim.enable = lib.mkEnableOption "nixvim";

  config = lib.mkIf config.dotfiles.features.nixvim.enable {
    programs.nixvim.enable = true;
  };
}
