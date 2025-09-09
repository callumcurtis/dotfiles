{ config, ... }:

{
  dotfiles.features.time = {
    enable = true;
    timeZone = config.dotfiles.constants.timeZone;
  };
  dotfiles.features.internationalization = {
    enable = true;
    locale = config.dotfiles.constants.locale;
  };
}
