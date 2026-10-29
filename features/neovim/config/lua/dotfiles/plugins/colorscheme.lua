return {
  "catppuccin/nvim",
  name = "catppuccin-nvim",
  lazy = false,
  priority = 1000,                   -- load before any other plugins
  config = function()
    -- Inside tmux, the focused split leaves its background to tmux, so the tmux pane's focus shows through. Outside
    -- tmux, it draws the focused background itself.
    local active_background = vim.env.TMUX and "NONE" or vim.g.active_background
    require("catppuccin").setup({
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          Normal = { bg = active_background },
          NormalNC = { bg = vim.g.inactive_background },
          NvimTreeNormal = { bg = active_background },
          NvimTreeNormalNC = { bg = vim.g.inactive_background },
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
