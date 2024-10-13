return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local icons = require("dotfiles.icons")

      require("nvim-tree").setup({
        view = {
          width = 30,
          adaptive_size = true,
          cursorline = true,
          side = "left",
          number = true,
          relativenumber = true,
          signcolumn = "yes",
        },
        sort = {
          sorter = "name",
          folders_first = true,
          files_first = false,
        },
        renderer = {
          symlink_destination = true,
          indent_markers = {
            enable = false,
            inline_arrows = true,
          },
          icons = {
            webdev_colors = true,
            web_devicons = {
              file = {
                enable = true,
                color = true,
              },
              folder = {
                enable = false,
              },
            },
            git_placement = "after",
            padding = " ",
            symlink_arrow = " ➛ ",
            modified_placement = "after",
            diagnostics_placement = "signcolumn",
            bookmarks_placement = "signcolumn",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
              diagnostics = true,
              bookmarks = true,
            },
            glyphs = {
              default = icons.ui.Text,
              symlink = icons.ui.FileSymlink,
              bookmark = icons.ui.BookMark,
              modified = icons.ui.Circle,
              folder = {
                arrow_closed = icons.ui.TriangleShortArrowRight,
                arrow_open = icons.ui.TriangleShortArrowDown,
                default = icons.ui.Folder,
                open = icons.ui.FolderOpen,
                empty = icons.ui.EmptyFolder,
                empty_open = icons.ui.EmptyFolderOpen,
                symlink = icons.ui.FolderSymlink,
                symlink_open = icons.ui.FolderOpen,
              },
              git = {
                unstaged = icons.git.FileUnstaged,
                staged = icons.git.FileStaged,
                unmerged = icons.git.FileUnmerged,
                renamed = icons.git.FileRenamed,
                untracked = icons.git.FileUntracked,
                deleted = icons.git.FileDeleted,
                ignored = icons.git.FileIgnored,
              },
            },
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
          debounce_delay = 50,
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = icons.diagnostics.BoldHint,
            info = icons.diagnostics.BoldInformation,
            warning = icons.diagnostics.BoldWarning,
            error = icons.diagnostics.BoldError,
          },
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
      })

      local keymap = vim.keymap
      local api = require("nvim-tree.api")

      keymap.set("n", "l", api.node.open.edit, { desc = "Open" })
      keymap.set("n", "h", api.node.navigate.parent_close, { desc = "Collapse" })

      keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
      keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Focus current file in explorer" })
    end
  }
}
