{ config, lib, isNixos, ... }:

{
  options.dotfiles.features.networking.enable = lib.mkEnableOption "networking";

  config = lib.optionalAttrs isNixos (lib.mkIf config.dotfiles.features.networking.enable {
    networking.networkmanager.enable = true;
  });
}

