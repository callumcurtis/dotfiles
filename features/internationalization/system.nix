{ config, lib, ... }:

{
  options.dotfiles.features.internationalization = {
    enable = lib.mkEnableOption "internationalization";
    locale = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.dotfiles.features.internationalization.enable {
    i18n.defaultLocale = config.dotfiles.features.internationalization.locale;
  };
}
