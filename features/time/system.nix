{ config, lib, ... }:

{
  options.dotfiles.features.time = {
    enable = lib.mkEnableOption "time";
    timeZone = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.dotfiles.features.time.enable {
    time.timeZone = config.dotfiles.features.time.timeZone;
  };
}
