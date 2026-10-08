return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    max_lines = 5,
    multiline_threshold = 1,
    trim_scope = "outer",
  },
}
