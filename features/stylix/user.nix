# NOTE: the stylix module must be added to your host's list of NixOS modules.

{ pkgs, config, lib, dotfiles, ... }:

{
  options.dotfiles.features.stylix = {
    enable = lib.mkEnableOption "stylix";
    theme = dotfiles.lib.mkTypedOption lib.types.path;
    # From the theme: backgrounds for focused and unfocused tmux panes and Neovim splits. The focused one is base16's
    # lighter background (base01), the rest keep the default background (base00).
    activeBackground = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      default = config.lib.stylix.colors.withHashtag.base01;
    };
    inactiveBackground = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      default = config.lib.stylix.colors.withHashtag.base00;
    };
  };

  config = lib.mkIf config.dotfiles.features.stylix.enable {
    stylix = {
      enable = true;
      targets = {
        # Avoids: extension “user-theme@gnome-shell-extensions.gcampax.github.com” does not exist
        gnome.enable = false;
      };
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
    };
  };
}
