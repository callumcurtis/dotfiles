return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "onsails/lspkind.nvim", -- completion-type pictograms
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
      completion = { completeopt = "menu,menuone,preview,noselect" },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.config.disable,
        ["<C-n>"] = cmp.config.disable,
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp"}, -- lsp
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),

      formatting = {
        format = function(entry, vim_item)
          -- use lspkind for completion-type pictograms in completion menu
          vim_item = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          })(entry, vim_item)
          vim_item.dup = 0
          return vim_item
        end,
      },
    })
  end,
}
