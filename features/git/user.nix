{ config, lib, pkgs, dotfiles, ... }:

let
  gpos = pkgs.writeShellScriptBin "gpos" ''
    set -euo pipefail

    yes=0
    range="origin/main..HEAD"

    while [ "$#" -gt 0 ]; do
      case "$1" in
        --yes|-y)
          yes=1
          shift
          ;;
        *)
          range="$1"
          shift
          ;;
      esac
    done

    branches=$(git log --oneline "$range" --pretty=%D \
      | sed 's/.*HEAD -> \([^,)]*\).*/\1/' \
      | sed -E 's/origin\/[^, ]*(, )?//g' \
      | sed 's/, $//' \
      | tac \
      | grep -v '^$' || true)

    if [ -z "$branches" ]; then
      echo "No branches to push for range: $range"
      exit 0
    fi

    if [ "$yes" -ne 1 ]; then
      echo "The following branches will be force-pushed to origin:"
      echo "$branches" | sed 's/^/  /'
      printf 'Proceed? [y/N] '
      read -r reply
      case "$reply" in
        y|Y|yes|Yes) ;;
        *) echo "Aborted."; exit 1 ;;
      esac
    fi

    echo "$branches" | xargs -I {} git push origin --force-with-lease {}
  '';
in
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
      settings = {
        user.name = config.dotfiles.features.git.user.name;
        user.email = config.dotfiles.features.git.user.email;
        rerere.enabled = true;
        init.defaultBranch = "main";
        push.default = "simple";
      };
    };

    home.packages = [ gpos ];

    home.shellAliases = {
      gf = "git fetch";
      gs = "git status";
      gsl = "git stash list";
      gss = "git stash save -m";
      gsss = "git stash save --staged -m";
      gsp = "git stash pop";
      gsa = "git stash apply";
      gsha = "git rev-parse HEAD";
      gl = "git log --oneline";
      gll = "git log";
      gd = "git diff";
      gdh = "git diff HEAD";
      gds = "git diff --staged";
      ga = "git add";
      gc = "git commit";
      gca = "git commit --amend";
      gco = "git checkout";
      gcob = "git checkout -b";
      gpo = "git push origin --force-with-lease";
      grb = "git rebase -i --update-refs";
      grl = "git reflog";
      gr = "git restore";
      grs = "git restore --staged";
      gR = "git reset";
      gRh = "git reset --hard";
      gbsc = "git branch --show-current";
    };
  };
}
