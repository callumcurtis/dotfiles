return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },

  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = { enable = true },
      autotag = { enable = true },
      ensure_installed = {},
      indent = { enable = true },
      auto_install = false,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<TAB>',
          scope_incremental = false,
          node_incremental = '<TAB>',
          node_decremental = '<S-TAB>',
        },
      },
    })
  end,
}
