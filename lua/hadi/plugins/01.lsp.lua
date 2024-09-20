-- NOTE: to config lsps; head to the mason_lspconfig table and make the changes there

-- nvim-lspconfig.nvim: the LSP server for neovim.
-- this plugin manages the interaction between lsp servers and neovim
local nvim_lspconfig = {
  "neovim/nvim-lspconfig",
  config = function()
  end
}

-- mason.nvim: manages installation of LSP servers, linters, formatters, etc
-- this plugin basically installs all required lsp servers for us
local mason = {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end
}

-- mason-lspconfig.nvim: eaiser configuration of LSPs, linters, formatters, etc with this plugin
-- this pluging makes it easy to integerate lsp, linters, formatters with lsp-config, and mason
local mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
  },
  config = function()
    require("mason-lspconfig").setup(
      {
        ensure_installed = { "lua_ls", "gopls" }
      }
    )

    local on_attach = function(client, bufnr)
      local keymap = vim.keymap
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- Keybindings for LSP functions
      -- keymap.set("n", "<leader>+", "<C-a>", { desc = "increment number" }) -- increment
      keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', vim.tbl_extend('force', opts, { desc = "" }))
      keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', vim.tbl_extend('force', opts, { desc = "" }))
      keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', vim.tbl_extend('force', opts, { desc = "" }))
      keymap.set('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', vim.tbl_extend('force', opts, { desc = "" }))
      keymap.set('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>',
        vim.tbl_extend('force', opts, { desc = "" }))

      -- Optional: Diagnostics
      if client.server_capabilities.diagnosticsProvider then
        vim.cmd('autocmd CursorHold <buffer> lua vim.diagnostic.open_float(nil, {focus=false})')
      end
    end

    local lspconfig = require("lspconfig")
    local util = require("lspconfig/util")

    -- lus_ls setup
    lspconfig.lua_ls.setup({})

    -- gopls setup
    lspconfig.gopls.setup({
      on_attach = on_attach,
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          staticcheck = true,
          gofumpt = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    })
  end
}

local mason_null_ls = {
  "jay-babu/mason-null-ls.nvim",
  dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        -- List formatters and linters you want to install
        "gofmt",      -- Go formatter
        "black",      -- Python formatter
        "rustfmt",    -- Rust formatter
        "clippy",     -- Rust linter
        "shfmt",      -- Bash formatter
        "shellcheck", -- Bash linter
      },
      automatic_installation = true,
    })
  end
}

return {
  nvim_lspconfig,
  mason,
  mason_lspconfig,
  mason_null_ls
}
