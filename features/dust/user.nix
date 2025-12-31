{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.dust.enable = lib.mkEnableOption "dust";

  config = lib.mkIf config.dotfiles.features.dust.enable {
    home.packages = with pkgs; [
      dust
    ];
  };
}
