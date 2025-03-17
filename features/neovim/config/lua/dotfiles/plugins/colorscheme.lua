return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,                   -- load before any other plugins
  config = function()
    vim.cmd.colorscheme "catppuccin-mocha" -- load the colorscheme
  end,
}
