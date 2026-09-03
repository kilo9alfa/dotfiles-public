-- LSP: the "language server" layer that gives real code intelligence.
--
-- Treesitter (see treesitter.lua) only understands SYNTAX — it can colour code
-- and tell you "this is a function name". An LSP server understands MEANING —
-- where a symbol is defined, what type it has, what else references it.
-- That is why `gd` needs this file and treesitter alone was never enough.
--
-- Neovim 0.11+ ships the LSP client in core. nvim-lspconfig no longer wires
-- anything up itself; it just supplies ready-made server definitions (the
-- command to run, which filetypes, how to find the project root) as `lsp/*.lua`
-- files. We pick the ones we want with `vim.lsp.enable`.
--
-- Servers must be installed separately, on PATH:
--   ts_ls -> npm i -g typescript-language-server
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Turn on the servers we have installed. Add more names here as you
      -- install them (e.g. "lua_ls" after `brew install lua-language-server`).
      vim.lsp.enable({ "ts_ls" })

      -- How errors and warnings are shown.
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        severity_sort = true,
        float = { border = "rounded", source = true },
      })

      -- Keymaps are set only once a server actually attaches to the buffer,
      -- so they never shadow anything in a plain markdown or text file.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local function map(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("<F12>", vim.lsp.buf.definition, "Go to definition") -- VS Code muscle memory
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gi", vim.lsp.buf.implementation, "Go to implementation")
          map("gr", vim.lsp.buf.references, "List references")
          map("K", vim.lsp.buf.hover, "Hover: show type / docs")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>e", vim.diagnostic.open_float, "Show diagnostic under cursor")
          map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous diagnostic")
          map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")

          -- <C-x><C-o> gives type-aware completion; this makes it fire as you type.
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
          end
        end,
      })
    end,
  },
}
