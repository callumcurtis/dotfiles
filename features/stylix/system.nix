# NOTE: the stylix module must be added to your host's list of NixOS modules.

{ pkgs, config, lib, dotfiles, isNixos, isDarwin, ... }:

{
  options.dotfiles.features.stylix = {
    enable = lib.mkEnableOption "stylix";
    wallpaper = dotfiles.lib.mkTypedOption lib.types.path;
    theme = dotfiles.lib.mkTypedOption lib.types.path;
  };

  config = lib.mkIf config.dotfiles.features.stylix.enable (lib.mkMerge [
    {
      stylix = {
        enable = true;
        image = config.dotfiles.features.stylix.wallpaper;
        polarity = "dark";
        base16Scheme = config.dotfiles.features.stylix.theme;
        fonts = {
          sizes = {
            terminal = 9;
            desktop = 9;
            popups = 9;
            applications = 10;
          };
          monospace = {
            package = pkgs.nerd-fonts.fira-mono;
            name = "FiraMono";
          };
          sansSerif = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Sans";
          };
          serif = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Serif";
          };
        };
      } // lib.optionalAttrs isNixos {
        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Original-Ice";
          size = 24;
        };
      };
    }
    (lib.optionalAttrs isDarwin {
      # Stylix cannot set the wallpaper on darwin; use desktoppr.
      system.activationScripts.postActivation.text = ''
        loggedInUser=$(/usr/bin/stat -f "%Su" /dev/console)
        /usr/bin/sudo -u "$loggedInUser" ${pkgs.desktoppr}/bin/desktoppr ${config.dotfiles.features.stylix.wallpaper}
      '';
    })
  ]);
}
