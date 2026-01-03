{ config, lib, ... }:

{
  options.dotfiles.features.claude-code.enable = lib.mkEnableOption "claude-code";

  config = lib.mkIf config.dotfiles.features.claude-code.enable {
    programs.claude-code = {
      enable = true;
    };
  };
}
