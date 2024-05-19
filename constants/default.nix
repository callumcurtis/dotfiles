{ config, ... }:

{
  options.dotfiles.constants = {
    name.full = config.dotfiles.lib.mkConstantOption "Callum Curtis";
    email.github.noreply = config.dotfiles.lib.mkConstantOption "105407637+callumcurtis@users.noreply.github.com";
  };
}

