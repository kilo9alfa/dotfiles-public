local o = vim.opt

o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true
o.scrolloff = 8
o.sidescrolloff = 8

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

o.splitbelow = true
o.splitright = true

-- A closed fold shows the real first line of the section — syntax-highlighted,
-- with conceal applied — instead of Neovim's "+--  4 lines: ## Heading" summary.
-- Empty foldtext is the Neovim 0.10+ way to ask for this; the space fillchar
-- stops a trail of dashes being drawn after it.
o.foldtext = ""
o.fillchars:append({ fold = " " })

o.termguicolors = true
o.background = "dark"

o.undofile = true
o.swapfile = false
o.backup = false

o.clipboard = "unnamedplus"
o.mouse = "a"

o.wrap = true
o.linebreak = true
o.conceallevel = 2      -- hide markup (**, [[ ]], link urls) — Obsidian-like rendering
o.concealcursor = ""    -- but reveal raw markup on the line the cursor sits on
o.spelllang = { "en", "es" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = ""

    -- Obsidian-style heading folds, via treesitter.
    -- Deferred: the treesitter parser attaches in its own FileType
    -- autocmd (plugins/treesitter.lua), which runs after this one, so
    -- setting foldexpr synchronously here would compute folds before
    -- the parser exists (always "no fold found").
    vim.schedule(function()
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt_local.foldenable = true
      -- Which heading depth is open on load. 0 = only H1 lines visible,
      -- 1 = H1 sections open with H2 collapsed, 2 = down to H3, 99 = all open.
      -- zR opens everything, zM closes everything, zx resets back to this.
      vim.opt_local.foldlevel = 1
    end)
  end,
})
