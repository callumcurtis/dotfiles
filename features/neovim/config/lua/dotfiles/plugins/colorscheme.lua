return {
  "catppuccin/nvim",
  name = "catppuccin-nvim",
  lazy = false,
  priority = 1000,                   -- load before any other plugins
  config = function()
    require("catppuccin").setup({
      custom_highlights = function(colors)
        return {
          -- nvim-treesitter-context
          TreesitterContext = { bg = colors.surface0 },
          TreesitterContextLineNumber = { fg = colors.overlay1, bg = colors.surface0 },
          TreesitterContextBottom = { underline = true, sp = colors.surface2 },
        }
      end,
    })
    vim.cmd.colorscheme "catppuccin-mocha" -- load the colorscheme
  end,
}
