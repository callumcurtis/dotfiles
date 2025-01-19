-- remove trailing whitespace on file write
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
      -- save and restore cursor position
      local pos = vim.fn.getpos(".")
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.setpos(".", pos)
  end,
})
