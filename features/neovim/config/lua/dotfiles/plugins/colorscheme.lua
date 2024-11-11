-- TODO(#1): use stylix to style neovim.
return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,                   -- load before any other plugins
  config = function()
    vim.cmd.colorscheme "catppuccin" -- load the colorscheme
  end,
}
