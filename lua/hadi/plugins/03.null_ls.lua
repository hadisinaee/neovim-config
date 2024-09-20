local plugin = {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Format on save
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
  end
}

return plugin
