{ config, lib, pkgs, isDarwin, ... }:

{
  options.dotfiles.features.make-darwin-linux-like.enable = lib.mkEnableOption "make-darwin-linux-like";

  config = lib.optionalAttrs isDarwin (lib.mkIf config.dotfiles.features.make-darwin-linux-like.enable {
    home.packages = with pkgs; [
      coreutils
      util-linux
    ];
  });
}
