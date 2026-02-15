{ config, lib, dotfiles, isNixos, ... }:

{
  options.dotfiles.features.internationalization = {
    enable = lib.mkEnableOption "internationalization";
    locale = dotfiles.lib.mkTypedOption lib.types.str;
  };

  config = lib.optionalAttrs isNixos (lib.mkIf config.dotfiles.features.internationalization.enable {
    i18n.defaultLocale = config.dotfiles.features.internationalization.locale;
  });
}
