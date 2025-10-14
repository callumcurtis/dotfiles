{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.yazi.enable = lib.mkEnableOption "yazi";

  config = lib.mkIf config.dotfiles.features.yazi.enable {
    home.packages = with pkgs; [
      (symlinkJoin {
        name = "yazi";
        paths = [
          yazi
          ueberzugpp
        ];
      })
    ];
  };
}

