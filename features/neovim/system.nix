{ config, lib, ... }:

{
  options.dotfiles.features.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf config.dotfiles.features.neovim.enable {
    services.xserver.xkb.options = "caps:escape";
  };
}
