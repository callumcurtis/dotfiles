{ config, lib, dotfiles, ... }:

{
  options.dotfiles.features.internationalization = {
    enable = lib.mkEnableOption "internationalization";
    locale = dotfiles.lib.mkTypedOption lib.types.str;
  };

  config = lib.mkIf config.dotfiles.features.internationalization.enable {
    i18n.defaultLocale = config.dotfiles.features.internationalization.locale;
  };
}
