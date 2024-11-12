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
        catppuccin-nvim
        indent-blankline-nvim
        lualine-nvim
        nvim-tree-lua
        nvim-web-devicons
        telescope-nvim
        telescope-fzf-native-nvim
        which-key-nvim
      ];
    };

    xdg.configFile."nvim/lua" = {
      recursive = true;
      source = ./config/lua;
    };

    xdg.configFile."nvim/init.lua".source = pkgs.substitute {
      src = ./config/init.lua;
      substitutions = [
        "--subst-var-by" "packpath" "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start"
      ];
    };
  };
}
