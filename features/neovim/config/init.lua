require("options")
require("keymaps")

-- TODO: create lazy module
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- import plugins from lua/plugins
  },
  performance = {
    reset_packpath = false,
    rtp = { reset = false },
  },
  dev = {
    path = "@packpath@", -- substituted in the Nix layer
    patterns = { "" },   -- specify that all of our plugins will use the dev dir. Empty string is a wildcard.
  },
  install = {
    missing = false, -- safeguard in case we forget to install a plugin with Nix
  },
})
