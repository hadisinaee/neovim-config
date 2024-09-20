-- nvim-cmp and its configuration
local nvim_cmp = {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',     -- LSP source for nvim-cmp
      'hrsh7th/cmp-buffer',       -- Buffer source for nvim-cmp
      'hrsh7th/cmp-path',         -- Path source for nvim-cmp
      'hrsh7th/cmp-cmdline',      -- Cmdline source for nvim-cmp
      'L3MON4D3/LuaSnip',         -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- LuaSnip source for nvim-cmp
      'neovim/nvim-lspconfig',    -- LSP configuration
      'onsails/lspkind.nvim',     -- Optional: lspkind for icons in completion
    },
    config = function()
      -- nvim-cmp setup
      local cmp = require('cmp')
      local lspkind = require('lspkind') -- Optional, for icons in completion

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For LuaSnip snippets
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Confirm completion
          ['<C-e>'] = cmp.mapping.abort(),                    -- Abort completion
        },
        sources = {
          { name = 'nvim_lsp' }, -- LSP source
          { name = 'luasnip' },  -- Snippets source
          { name = 'buffer' },   -- Buffer source
          { name = 'path' },     -- Path source
          { name = 'cmdline' },  -- Cmdline source
        },
        formatting = {
          format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }), -- Optional, for icons and formatting
        },
      })

      -- Cmdline completion setup
      cmp.setup.cmdline(':', {
        sources = {
          { name = 'cmdline' },
          { name = 'path' },
        },
      })

      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' },
        },
      })
    end,
  },
}

return nvim_cmp
