return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Inline images in markdown, rendered via Ghostty's Kitty graphics protocol.
      -- `doc` mode auto-renders images referenced in markdown/LaTeX as you scroll.
      image = {
        enabled = true,
        doc = {
          enabled = true,
          inline = true,   -- show images inline in the buffer (Ghostty supports this)
          float = true,    -- also allow a floating preview
        },
      },
      -- Distraction-free writing mode.
      zen = { enabled = true },
      -- File tree in a sidebar, with git status colouring per file.
      -- Needs `picker`, which is what draws and filters the list.
      explorer = { enabled = true },
      picker = { enabled = true },
    },
    keys = {
      { "<leader>z",  function() require("snacks").zen() end,          desc = "Zen mode (focus)" },
      { "<leader>mi", function() require("snacks").image.hover() end,  desc = "Preview image under cursor" },
      -- <leader>fe, not <leader>e: the LSP buffer-local <leader>e (show
      -- diagnostic) would shadow it in any file with a language server.
      { "<leader>fe", function() require("snacks").explorer() end,     desc = "File tree (git status)" },
      { "<leader>gg", function() require("snacks").picker.git_status() end, desc = "Changed files (git status)" },
    },
  },
}
