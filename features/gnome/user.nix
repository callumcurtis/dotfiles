{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf config.dotfiles.features.gnome.enable { 
    home.packages = with pkgs; [
      xclip
    ];

    # TODO(#1): use stylix to style gnome fonts.
    fonts.fontconfig.enable = true;
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        document-font-name = "Liberation Sans 10";
        font-name = "Liberation Sans 10";
        monospace-font-name = "Liberation Mono 9";
     };
    };
  };
}
