-- Git changes while you edit: coloured marks in the left gutter showing which
-- lines you added, changed or deleted since the last commit — plus the ability
-- to preview, undo or stage a single block of changes (a "hunk") without
-- leaving the file.
--
-- This is the everyday companion to `cmux diff`, which is better for reading a
-- whole diff at once. Needs no external tools beyond git itself.
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "▎" },
        untracked    = { text = "┆" },
      },
      current_line_blame = false, -- toggle it on demand with <leader>gb
      current_line_blame_opts = { delay = 300, virt_text_pos = "eol" },
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function map(mode, keys, fn, desc)
          vim.keymap.set(mode, keys, fn, { buffer = buf, desc = "Git: " .. desc })
        end

        -- Move between changes. In a real diff (nvim -d) ]c/[c already mean
        -- this, so fall through to the built-in behaviour when we are in one.
        -- These are expression mappings, hence the returned keys.
        local function nav(key, dir)
          vim.keymap.set("n", key, function()
            if vim.wo.diff then return key end
            vim.schedule(function() gs.nav_hunk(dir) end)
            return "<Ignore>"
          end, { buffer = buf, expr = true, desc = "Git: " .. dir .. " change" })
        end
        nav("]c", "next")
        nav("[c", "prev")

        map("n", "<leader>gp", gs.preview_hunk, "Preview this change in a popup")
        map("n", "<leader>gr", gs.reset_hunk, "Undo this change")
        map("n", "<leader>gR", gs.reset_buffer, "Undo every change in this file")
        map("n", "<leader>gs", gs.stage_hunk, "Stage this change")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Unstage the last staged change")
        map("n", "<leader>gd", gs.diffthis, "Side-by-side diff of this file")
        map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle who-changed-this blame")
      end,
    },
  },
}
