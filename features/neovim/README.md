# Neovim

Plugins are installed through Nix and managed by lazy.

## Adding Plugins

To add a plugin, install the plugin in [user.nix](./user.nix) and configure it in [config/lua/dotfiles/plugins](./config/lua/dotfiles/plugins).

## Keymaps

The full list of keymaps can be found in [config/lua/dotfiles/keymaps.lua](./config/lua/dotfiles/keymaps.lua)
or by using the `which-key` plugin.

To make keymaps memorable, two categories of custom keymaps are used:
- Abbrevations
- Objects-Verb

### Abbreviations

Shorten common commands by moving them closer to the home row.
For example, `<leader>w` instead of `:w`.

### Objects-Verb

Ordering: `[object ...] verb`

Objects
- (t)ab
- (s)plit

Verbs
- (o)pen
- (f)ind
- (c)lose
- (b)ack
- (n)ext

Exceptions
- Pressing `object` twice closes the object (where it makes sense)

## Resources

- [Using lazy.nvim with Nix](https://nixalted.com/)
- [Example configuration #1](https://www.josean.com/posts/how-to-setup-neovim-2024)

