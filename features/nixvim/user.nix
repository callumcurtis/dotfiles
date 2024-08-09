{ config, lib, nixvim, ... }:

{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  options.dotfiles.features.nixvim.enable = lib.mkEnableOption "nixvim";

  config = lib.mkIf config.dotfiles.features.nixvim.enable {
    programs.nixvim = {
      enable = true;

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
    };
  };
}
