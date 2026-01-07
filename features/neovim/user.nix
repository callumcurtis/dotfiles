{ config, lib, pkgs, dotfiles, ... }:

{
  options.dotfiles.features.neovim = {
    enable = lib.mkEnableOption "neovim";
    asDefaultEditor = dotfiles.lib.mkTypedOptionWithDefault lib.types.bool false;
  };

  config = lib.mkIf config.dotfiles.features.neovim.enable {
    programs.neovim = {
      enable = true;

      plugins = let
        telescope-recent-files = pkgs.vimUtils.buildVimPlugin {
          pname = "telescope-recent-files";
          version = "20251230";
          src = pkgs.fetchFromGitHub {
            owner = "smartpde";
            repo = "telescope-recent-files";
            rev = "eb190c0baded1cbfa9d8767c817b054377683163";
            hash = "sha256-OxapSvSDdXFYxuza3Vf5acWTNEHg2okvhBUQJMV3hOQ=";
          };
          meta.homepage = "https://github.com/smartpde/telescope-recent-files";
        };
      in (with pkgs.vimPlugins; [
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
        nvim-treesitter-textobjects
        nvim-ts-autotag
        nvim-web-devicons
        telescope-fzf-native-nvim
        telescope-nvim
        todo-comments-nvim
        which-key-nvim
        gitsigns-nvim
        flash-nvim
        telescope-live-grep-args-nvim
      ]) ++ [ telescope-recent-files ];

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
