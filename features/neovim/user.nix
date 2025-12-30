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
        cmp-nvim-lsp
        cmp-path
        indent-blankline-nvim
        lspkind-nvim
        lualine-nvim
        nvim-autopairs
        nvim-bqf
        nvim-cmp
        nvim-lspconfig
        nvim-tree-lua
        nvim-treesitter.withAllGrammars
        nvim-ts-autotag
        nvim-web-devicons
        telescope-frecency-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        todo-comments-nvim
        which-key-nvim
        gitsigns-nvim
        flash-nvim
      ];

      extraPackages = with pkgs; [
        llvmPackages_20.clang-tools
        lua-language-server
        nil
        nodePackages.bash-language-server
        pyright
        rust-analyzer
        typescript-language-server
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
