{ config, lib, isNixos, ... }:

{
  options.dotfiles.features.printing.enable = lib.mkEnableOption "printing";

  config = lib.optionalAttrs isNixos (lib.mkIf config.dotfiles.features.printing.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  });
}
