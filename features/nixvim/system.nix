{ config, lib, ... }:

{
  options.dotfiles.features.nixvim.enable = lib.mkEnableOption "nixvim";

  config = lib.mkIf config.dotfiles.features.nixvim.enable {
    services.xserver.xkb.options = "caps:escape";
  };
}
