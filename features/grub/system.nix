{ config, lib, isNixos, ... }:

{
  options.dotfiles.features.grub.enable = lib.mkEnableOption "grub";

  config = lib.optionalAttrs isNixos (lib.mkIf config.dotfiles.features.grub.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        fontSize = 48;
      };
    };
  });
}
