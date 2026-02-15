{ config, lib, pkgs, isNixos, ... }:

{
  options.dotfiles.features.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.optionalAttrs isNixos (lib.mkIf config.dotfiles.features.gnome.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.excludePackages = with pkgs; [ xterm ];

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs; [ gnome-console ];

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
  });
}
