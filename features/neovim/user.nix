{ config, lib, pkgs, dotfiles, ... }:

{
  options.dotfiles.features.neovim = {
    enable = lib.mkEnableOption "neovim";
    asDefaultEditor = dotfiles.lib.mkTypedOptionWithDefault lib.types.bool false;
  };

  config = lib.mkIf config.dotfiles.features.neovim.enable {
    programs.neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
        # plugin manager
        lazy-nvim
        # plugins
        catppuccin-nvim
        cmp-buffer
        cmp-path
        indent-blankline-nvim
        lspkind-nvim
        lualine-nvim
        luasnip
        nvim-autopairs
        nvim-cmp
        nvim-tree-lua
        nvim-treesitter.withAllGrammars
        nvim-ts-autotag
        nvim-web-devicons
        telescope-nvim
        telescope-fzf-native-nvim
        which-key-nvim
      ];
    };

    home.shellAliases = lib.mkIf config.dotfiles.features.neovim.asDefaultEditor {
      v = "${config.programs.neovim.finalPackage}/bin/nvim";
    };

    home.sessionVariables = lib.mkIf config.dotfiles.features.neovim.asDefaultEditor {
      EDITOR = "${config.programs.neovim.finalPackage}/bin/nvim";
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
