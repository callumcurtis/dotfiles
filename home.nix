{ pkgs, ... }:

{
  home.username = "callumcurtis";
  home.homeDirectory = "/home/callumcurtis";

  fonts.fontconfig.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      document-font-name = "Liberation Sans 10";
      font-name = "Liberation Sans 10";
      monospace-font-name = "Liberation Mono 9";
   };
  };

  home.packages = with pkgs; [
    lunarvim
    google-chrome
    (pkgs.nerdfonts.override { fonts = ["FiraMono"]; })
  ];

  programs.fish.enable = true;

  programs.zoxide.enable = true;

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      default_shell = "fish";
      theme = "tokyo-night-dark";
    };
  };

  programs.eza = {
    enable = true;
    icons = true;
    git = true;
  };

  programs.git = {
    enable = true;
    userName = "Callum Curtis";
    userEmail = "105407637+callumcurtis@users.noreply.github.com";
    extraConfig = {
      rerere.enabled = true;
      init.defaultBranch = "main";
    };
    delta = {
      enable = true;
      options = {
        side-by-side = true;
      };
    };
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
