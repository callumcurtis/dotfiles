{ dotfiles, pkgs, ... }:

let
  mk = dotfiles.lib.mkConstantOption;
in {
  options.dotfiles.constants = {
    name.full = mk "Callum Curtis";
    email.github.noreply = mk "105407637+callumcurtis@users.noreply.github.com";
    timeZone = mk "Canada/Pacific";
    locale = mk "en_CA.UTF-8";
    shell = mk "${pkgs.fish}/bin/fish";
    # Gallery: https://tinted-theming.github.io/tinted-gallery
    # Suggestions:
    # - catppuccin-mocha
    # - material-palenight
    # - rose-pine-moon
    # - saga
    # - spaceduck
    # - stella
    # - tokyo-night-moon
    theme = mk "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    # Path to a wallpaper within the flake's wallpapers input
    # To use a different set of wallpapers, override the wallpapers input
    wallpaper = mk "${dotfiles.wallpapers}/1ddbba008a5.png";
  };
}

