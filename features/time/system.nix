{ config, lib, dotfiles, isNixos, ... }:

{
  options.dotfiles.features.time = {
    enable = lib.mkEnableOption "time";
    timeZone = dotfiles.lib.mkTypedOption lib.types.str;
  };

  config = lib.optionalAttrs isNixos (lib.mkIf config.dotfiles.features.time.enable {
    time.timeZone = config.dotfiles.features.time.timeZone;
  });
}
