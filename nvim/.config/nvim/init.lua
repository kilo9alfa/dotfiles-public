vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("options")
require("keymaps")
require("lazy-bootstrap")

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "catppuccin", "habamax" } },
  checker = { enabled = false },
  rocks = { enabled = false }, -- no plugin here needs luarocks; silences :checkhealth lazy
  change_detection = { notify = false },
})
