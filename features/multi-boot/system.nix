{ config, lib, isNixos, ... }:

{
  options.dotfiles.features.multi-boot.windows.enable = lib.mkEnableOption "support for windows in multi-boot";

  config = lib.optionalAttrs isNixos (lib.mkIf config.dotfiles.features.multi-boot.windows.enable {
    time.hardwareClockInLocalTime = true;
  });
}
