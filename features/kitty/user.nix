{ config, lib, pkgs, dotfiles, ... }:

{
  options.dotfiles.features.kitty = {
    enable = lib.mkEnableOption "kitty";
    shell = dotfiles.lib.mkTypedOption lib.types.path;
  };

  config = lib.mkIf config.dotfiles.features.kitty.enable {
    # TODO(#1): use stylix for theme, font type, and font size

    home.packages = with pkgs; [
      (nerdfonts.override { fonts = ["FiraMono"]; })
    ];

    programs.kitty = {
      enable = true;
      font = {
        name = "FiraMono Nerd Font";
        size = 10;
      };
      theme = "Tokyo Night Moon";
      settings = {
        shell = config.dotfiles.features.kitty.shell;
      };
    };
  };
}
