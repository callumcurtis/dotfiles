{ config, lib, dotfiles, isDarwin ? false, ... }:

{
  options.dotfiles.features.internationalization = {
    enable = lib.mkEnableOption "internationalization";
    locale = dotfiles.lib.mkTypedOption lib.types.str;
  };

  config = lib.optionalAttrs (!isDarwin) (lib.mkIf config.dotfiles.features.internationalization.enable {
    i18n.defaultLocale = config.dotfiles.features.internationalization.locale;
  });
}
