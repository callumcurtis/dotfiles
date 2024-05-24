{ config, lib, ... }:

{
  options.dotfiles.features.networking.enable = lib.mkEnableOption "networking";

  config = lib.mkIf config.dotfiles.features.networking.enable {
    networking.networkmanager.enable = true;
  };
}

