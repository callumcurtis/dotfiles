{ config, lib, isDarwin, ... }:

{
  options.dotfiles.features.blurred.enable = lib.mkEnableOption "blurred";

  config = lib.optionalAttrs isDarwin (lib.mkIf config.dotfiles.features.blurred.enable {
    # Enable our custom homebrew feature
    dotfiles.features.homebrew.enable = true;
    # Declare the blurred cask
    dotfiles.features.homebrew.casks = [ "blurred" ];
  });
}
