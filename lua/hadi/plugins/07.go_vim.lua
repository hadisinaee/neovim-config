local plugin = {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  -- nvim-dap (for debugging)
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Basic configuration for nvim-dap
    end,
  },

  -- nvim-dap-ui (depends on nvim-dap)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    requires = { "mfussenegger/nvim-dap" }, -- This plugin depends on nvim-dap
    config = function()
      require("dapui").setup()
    end,
  },

  -- nvim-dap-virtual-text (depends on nvim-dap)
  {
    "theHamsta/nvim-dap-virtual-text",
    requires = { "mfussenegger/nvim-dap" }, -- This plugin depends on nvim-dap
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}

return plugin
