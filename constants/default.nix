{ config, ... }:

{
  options.dotfiles.constants = {
    name.full = config.dotfiles.lib.mkConstant "Callum Curtis";
    email.github.noreply = config.dotfiles.lib.mkConstant "105407637+callumcurtis@users.noreply.github.com";
  };
}

