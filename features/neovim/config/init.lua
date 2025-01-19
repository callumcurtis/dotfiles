require("dotfiles.options")
require("dotfiles.keymaps")
require("dotfiles.autocmds")

-- TODO: create lazy module
require("lazy").setup({
  spec = {
    { import = "dotfiles/plugins" }, -- import plugins from lua/dotfiles/plugins
  },
  performance = {
    reset_packpath = false,
    rtp = { reset = false },
  },
  dev = {
    path = "@packpath@", -- substituted in the Nix layer
    patterns = { "" },   -- specify that all plugins will use the dev dir - empty string is a wildcard
  },
  install = {
    missing = false, -- safeguard in case we forget to install a plugin with Nix
  },
})
