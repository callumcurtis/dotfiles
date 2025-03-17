{ config, lib, ... }:

{
  options.dotfiles.features.grub.enable = lib.mkEnableOption "grub";

  config = lib.mkIf config.dotfiles.features.grub.enable {
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
  };
}
