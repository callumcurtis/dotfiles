return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        frecency = {
          show_filter_column = false,
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("frecency")
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
