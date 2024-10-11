require("options")
require("keymaps")

-- TODO: create lazy module
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Import plugins from lua/plugins
  },
  performance = {
    reset_packpath = false,
    rtp = { reset = false },
  },
  dev = {
    path = "@packpath@", -- Substituted in the Nix layer
    patterns = { "" },   -- Specify that all of our plugins will use the dev dir. Empty string is a wildcard.
  },
  install = {
    missing = false, -- Safeguard in case we forget to install a plugin with Nix
  },
})
