-- for syntax highlighting stuff
local plugin = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { "bash", "lua", "python", "go", "rust"}, -- Install maintained parsers
      highlight = { enable = true },
      indent = { enable = true } -- Enable automatic indentation
    })
  end
}

return plugin
