{ config, lib, nixvim, ... }:

{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  options.dotfiles.features.nixvim.enable = lib.mkEnableOption "nixvim";

  config = lib.mkIf config.dotfiles.features.nixvim.enable {
    programs.nixvim = {
      enable = true;

      globals = {
        mapleader = " ";
      };

      opts = {
        # line numbering
        relativenumber = true;
        number = true;

        # whitespace
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        autoindent = true;
        signcolumn = "yes";

        # line wrapping
        wrap = false;

        # search
        ignorecase = true;
        smartcase = true;

        # line highlighting
        cursorline = true;

        # theming
        termguicolors = true;
        background = "dark";

        # backspace
        backspace = "indent,eol,start";

        # clipboard
        clipboard = "unnamedplus";

        # windows
        splitright = true;
        splitbelow = true;
      };

      keymaps = [
        # search
        {
          mode = ["n"];
          key = "<leader>nh";
          action = ":nohl<CR>";
          options.desc = "Clear search highlights";
        }

        # windows
        {
          mode = ["n"];
          key = "<leader>sv";
          action = "<C-w>v";
          options.desc = "Split window vertically";
        }
        {
          mode = ["n"];
          key = "<leader>sh";
          action = "<C-w>s";
          options.desc = "Split window horizontally";
        }
        {
          mode = ["n"];
          key = "<leader>we";
          action = "<C-w>=";
          options.desc = "Make windows equal size";
        }
        {
          mode = ["n"];
          key = "<leader>wx";
          action = "<cmd>close<CR>";
          options.desc = "Close current window";
        }
      ];
    };
  };
}
