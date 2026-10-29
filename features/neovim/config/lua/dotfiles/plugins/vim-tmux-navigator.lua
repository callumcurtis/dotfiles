-- Alt-h/j/k/l move between Neovim splits and tmux panes alike, Alt-o goes back to the previous one
-- (tmux sends these keys on to Neovim, see features/tmux/tmux.conf)
return {
  "christoomey/vim-tmux-navigator",
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_no_wrap = 1 -- stop at the edges, like tmux's bindings
  end,
  keys = {
    { "<M-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "i", "x", "t" }, desc = "Focus split/pane left" },
    { "<M-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "i", "x", "t" }, desc = "Focus split/pane below" },
    { "<M-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "i", "x", "t" }, desc = "Focus split/pane above" },
    { "<M-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "i", "x", "t" }, desc = "Focus split/pane right" },
    { "<M-o>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "n", "i", "x", "t" }, desc = "Focus previous split/pane" },
  },
}
