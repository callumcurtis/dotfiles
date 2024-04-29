{ pkgs, ... }:

{
  home.username = "callumcurtis";
  home.homeDirectory = "/home/callumcurtis";

  fonts.fontconfig.enable = true;

  # Packages installed to the user profile.
  home.packages = with pkgs; [
    lunarvim
    firefox
    fish
    (pkgs.nerdfonts.override { fonts = ["FiraMono"]; })
  ];

  programs.git = {
    enable = true;
    userName = "Callum Curtis";
    userEmail = "105407637+callumcurtis@users.noreply.github.com";
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraMono Nerd Font";
      size = 10;
    };
    theme = "Tokyo Night Moon";
    settings = {
      shell = "fish";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
