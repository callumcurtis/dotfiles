{ config, lib, pkgs, isDarwin, ... }:

{
  options.dotfiles.features.coreutils.enable = lib.mkEnableOption "coreutils";

  config = lib.optionalAttrs isDarwin (lib.mkIf config.dotfiles.features.coreutils.enable {
    home.packages = with pkgs; [
      coreutils
    ];
  });
}
