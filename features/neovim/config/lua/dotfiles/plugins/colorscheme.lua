return {
  "catppuccin/nvim",
  name = "catppuccin-nvim",
  lazy = false,
  priority = 1000,                   -- load before any other plugins
  config = function()
    require("catppuccin").setup()
    vim.cmd.colorscheme "catppuccin-mocha" -- load the colorscheme
  end,
}
