{ config, lib, isDarwin ? false, ... }:

{
  options.dotfiles.features.networking.enable = lib.mkEnableOption "networking";

  config = lib.optionalAttrs (!isDarwin) (lib.mkIf config.dotfiles.features.networking.enable {
    networking.networkmanager.enable = true;
  });
}

