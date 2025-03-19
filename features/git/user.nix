{ config, lib, dotfiles, ... }:

{
  options.dotfiles.features.git = {
    enable = lib.mkEnableOption "git";
    user = {
      name = dotfiles.lib.mkTypedOption lib.types.str;
      email = dotfiles.lib.mkTypedOption lib.types.str;
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
        push.default = "simple";
      };
      delta = {
        enable = true;
        options = {
          side-by-side = true;
          dark = true;
        };
      };
    };

    home.shellAliases = {
      gs = "git status";
      gl = "git log --oneline";
      gll = "git log";
      gd = "git diff";
      gdh = "git diff HEAD";
      gds = "git diff --staged";
      ga = "git add";
      gc = "git commit -m";
      gca = "git commit --amend";
      gpo = "git push origin";
    };
  };
}
