{ config, lib, pkgs, isDarwin ? false, ... }:

{
  options.dotfiles.features.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.optionalAttrs (!isDarwin) (lib.mkIf config.dotfiles.features.gnome.enable {
    home.packages = with pkgs; [
      xclip
    ];
  });
}
