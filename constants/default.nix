{ config, ... }:

{
  options.dotfiles.constants = {
    name.full = config.dotfiles.lib.mkConstantOption "Callum Curtis";
    email.github.noreply = config.dotfiles.lib.mkConstantOption "105407637+callumcurtis@users.noreply.github.com";
    timeZone = config.dotfiles.lib.mkConstantOption "Canada/Eastern";
    locale = config.dotfiles.lib.mkConstantOption "en_CA.UTF-8";
  };
}

