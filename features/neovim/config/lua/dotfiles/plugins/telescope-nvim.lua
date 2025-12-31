return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "smartpde/telescope-recent-files",
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
        recent_files = {
          only_cwd = true,
          show_current_file = true
        }
      }
    })

    telescope.load_extension("fzf")
    telescope.load_extension("recent_files")

    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope recent_files<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
