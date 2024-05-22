{ config, lib, pkgs, dotfiles, ... }:

{
  options.dotfiles.features.lunarvim = {
    enable = lib.mkEnableOption "lunarvim";
    asDefaultEditor = dotfiles.lib.mkTypedOptionWithDefault lib.types.bool false;
  };

  config = lib.mkIf config.dotfiles.features.lunarvim.enable {
    home.packages = with pkgs; [
      lunarvim
    ];

    home.sessionVariables = lib.mkIf config.dotfiles.features.lunarvim.asDefaultEditor {
      EDITOR = "${pkgs.lunarvim}/bin/lvim";
    };
  };
}

