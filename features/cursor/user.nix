{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.cursor.enable = lib.mkEnableOption "cursor";

  config = lib.mkIf config.dotfiles.features.cursor.enable {
    home.packages = with pkgs; [
      unstable.code-cursor-fhs
    ];
  };
}
