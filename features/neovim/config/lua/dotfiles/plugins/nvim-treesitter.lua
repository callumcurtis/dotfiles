return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("dotfiles_treesitter", { clear = true }),
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    require("nvim-ts-autotag").setup()

    require("nvim-treesitter-textobjects").setup({
      select = { lookahead = true },
      move = { set_jumps = true },
    })

    local select = require("nvim-treesitter-textobjects.select")
    for keys, query in pairs({
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    }) do
      vim.keymap.set({ "x", "o" }, keys, function()
        select.select_textobject(query, "textobjects")
      end, { desc = "Select " .. query })
    end

    local move = require("nvim-treesitter-textobjects.move")
    for keys, query in pairs({
      ["]f"] = "@function.outer",
      ["]c"] = "@class.outer",
    }) do
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_next_start(query, "textobjects")
      end, { desc = "Next " .. query .. " start" })
    end
    for keys, query in pairs({
      ["[f"] = "@function.outer",
      ["[c"] = "@class.outer",
    }) do
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_previous_start(query, "textobjects")
      end, { desc = "Previous " .. query .. " start" })
    end

    vim.keymap.set("n", "<TAB>", "van", { remap = true, desc = "Start node selection" })
    vim.keymap.set("x", "<TAB>", "an", { remap = true, desc = "Expand node selection" })
    vim.keymap.set("x", "<S-TAB>", "in", { remap = true, desc = "Shrink node selection" })
  end,
}
