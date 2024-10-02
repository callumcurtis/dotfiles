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

        # signs
        signcolumn = "yes";

        # line wrapping
        wrap = false;

        # search
        ignorecase = true;
        smartcase = true;

        # highlighting
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
        # Conventions:
        # - Use a prefix for command groups, such as "t" for tabs
        # - Use standard suffixes for actions
        #   - a for add
        #   - d for delete
        #   - m for move
        #   - b for back/previous
        #   - n for next

        # save/quit
        {
          mode = ["n"];
          key = "<leader>w";
          action = ":w<CR>";
          options.desc = "Write the buffer to the current file";
        }
        {
          mode = ["n"];
          key = "<leader>q";
          action = ":q<CR>";
          options.desc = "Quit the current window";
        }

        # search
        {
          mode = ["n"];
          key = "<leader>nh";
          action = ":nohl<CR>";
          options.desc = "Clear search highlights";
        }

        # increment/decrement
        {
          mode = ["n"];
          key = "+";
          action = "<C-a>";
          options.desc = "Increment number";
        }
        {
          mode = ["n"];
          key = "-";
          action = "<C-x>";
          options.desc = "Decrement number";
        }

        # splits
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
          key = "<leader>se";
          action = "<C-w>=";
          options.desc = "Make windows equal size";
        }
        {
          mode = ["n"];
          key = "<leader>sd";
          action = "<cmd>close<CR>";
          options.desc = "Close current window";
        }

        # tabs
        {
          mode = ["n"];
          key = "<leader>ta";
          action = "<cmd>tabnew<CR>";
          options.desc = "Open new tab";
        }
        {
          mode = ["n"];
          key = "<leader>td";
          action = "<cmd>tabclose<CR>";
          options.desc = "Close current tab";
        }
        {
          mode = ["n"];
          key = "<leader>tn";
          action = "<cmd>tabn<CR>";
          options.desc = "Go to next tab";
        }
        {
          mode = ["n"];
          key = "<leader>tb";
          action = "<cmd>tabp<CR>";
          options.desc = "Go to previous tab";
        }
      ];
    };
  };
}
