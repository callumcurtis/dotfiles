{ dotfiles, ... }:

{
  options.dotfiles.constants = {
    name.full = dotfiles.lib.mkConstant "Callum Curtis";
    email.github.noreply = dotfiles.lib.mkConstant "105407637+callumcurtis@users.noreply.github.com";
  };
}

