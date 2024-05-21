{ dotfiles, ... }:

{
  options.dotfiles.constants = {
    name.full = dotfiles.lib.mkConstantOption "Callum Curtis";
    email.github.noreply = dotfiles.lib.mkConstantOption "105407637+callumcurtis@users.noreply.github.com";
    timeZone = dotfiles.lib.mkConstantOption "Canada/Eastern";
    locale = dotfiles.lib.mkConstantOption "en_CA.UTF-8";
  };
}

