
{ config, lib, ... }:

{
  imports = [
    ../../features/user.nix
  ];

  # Meta.
  dotfiles.features.home-manager.enable = true;

  # Desktop environment.
  # TODO: the desktop environment should be selected by the system configuration
  dotfiles.features.gnome.enable = true;

  # GUI programs.
  dotfiles.features.google-chrome.enable = true;

  # Terminal configuration.
  dotfiles.features.kitty = {
    enable = true;
    shell = config.dotfiles.constants.shell;
  };
  dotfiles.features.fish.enable = true;
  dotfiles.features.zellij = {
    enable = true;
    shell = config.dotfiles.constants.shell;
  };
  dotfiles.features.neovim = {
    enable = true;
    asDefaultEditor = true;
  };
  dotfiles.features.stylix = {
    enable = true;
    wallpaper = config.dotfiles.constants.wallpaper;
    theme = config.dotfiles.constants.theme;
  };
  dotfiles.features.direnv.enable = true;
  dotfiles.features.zoxide.enable = true;
  dotfiles.features.eza.enable = true;
  dotfiles.features.ripgrep.enable = true;
  dotfiles.features.starship.enable = true;
  dotfiles.features.glow.enable = true;
  dotfiles.features.bat.enable = true;
  dotfiles.features.git = {
    enable = true;
    user.name = config.dotfiles.constants.name.full;
    user.email = config.dotfiles.constants.email.github.noreply;
  };
}
