{ config, lib, ... }:

{
  config = lib.mkIf config.dotfiles.features.nixvim.enable {
    programs.nixvim.opts = {
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

      # swapfile
      swapfile = false;
    };
  };
}
