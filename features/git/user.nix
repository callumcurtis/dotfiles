{ config, lib, ... }:

{
  options.dotfiles.features.git = {
    enable = lib.mkEnableOption "git";
    user = {
      name = lib.mkOption {
        type = lib.types.str;
      };
      email = lib.mkOption {
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf config.dotfiles.features.git.enable {
    programs.git = {
      enable = true;
      userName = config.dotfiles.features.git.user.name;
      userEmail = config.dotfiles.features.git.user.email;
      extraConfig = {
        rerere.enabled = true;
        init.defaultBranch = "main";
      };
      delta = {
        enable = true;
        options = {
          side-by-side = true;
        };
      };
    };
  };
}
