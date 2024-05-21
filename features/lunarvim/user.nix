{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.lunarvim = {
    enable = lib.mkEnableOption "lunarvim";
    asDefaultEditor = lib.mkEnableOption "lunarvim as default editor";
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

