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
    };

    home.shellAliases = {
      gs = "git status";
      gsl = "git stash list";
      gss = "git stash save -m";
      gsss = "git stash save --staged -m";
      gsp = "git stash pop";
      gsa = "git stash apply";
      gl = "git log --oneline";
      gll = "git log";
      gd = "git diff";
      gdh = "git diff HEAD";
      gds = "git diff --staged";
      ga = "git add";
      gc = "git commit -m";
      gca = "git commit --amend";
      gco = "git checkout";
      gcob = "git checkout -b";
      gpo = "git push origin --force-with-lease";
      # TODO: add "gpos" which pushes all branches in the stack
      grb = "git rebase -i --update-refs";
      grl = "git reflog";
    };
  };
}
