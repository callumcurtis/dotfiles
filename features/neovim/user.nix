{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf config.dotfiles.features.neovim.enable {
    programs.neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
        # plugin manager
        lazy-nvim
        # plugins
        which-key-nvim
      ];

      extraLuaConfig = ''
        vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
        require("lazy").setup({
          spec = {
            -- Import plugins from lua/plugins
            { import = "plugins" },
          },
          performance = {
            reset_packpath = false,
            rtp = {
                reset = false,
              }
            },
          dev = {
            path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
            patterns = {""}, -- Specify that all of our plugins will use the dev dir. Empty string is a wildcard.
          },
          install = {
            -- Safeguard in case we forget to install a plugin with Nix
            missing = false,
          },
        })
      '';
    };

    xdg.configFile."nvim/lua" = {
      recursive = true;
      source = ./lua;
    };
  };
}
