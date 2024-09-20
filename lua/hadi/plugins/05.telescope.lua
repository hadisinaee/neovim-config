local plugin = {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8", -- optional: specify a version or commit hash
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  }, -- required dependency
  config = function()
    require("telescope").setup({
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        path_display = { "smart" },
        layout_strategy = 'vertical',
        mappings = {
          i = { -- Insert mode
            ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous,
          },
          n = { -- Normal mode
            ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- search hidden files as well
          theme = "ivy", -- optional: set a picker theme
        },
        treesitter = {
          theme = "ivy",
        },
        lsp_document_symbols = {
          theme = "ivy",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- enable fuzzy searching
          override_generic_sorter = true, -- override the default generic sorter
          override_file_sorter = true,    -- override the default file sorter
        },
      },
    })

    require("telescope").load_extension("fzf")

    -- key binding is here
    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>",
      { desc = "find all files", noremap = true, silent = true })
    keymap.set("n", "<leader>fta", "<cmd>Telescope treesitter<CR>",
      { desc = "find all symbols", noremap = true, silent = true })
    keymap.set("n", "<leader>ftf", "<cmd>Telescope lsp_document_symbols<CR>",
      { desc = "find all functions and methods", noremap = true })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",
      { desc = "live grep", noremap = true, silent = true })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>",
      { desc = "find in buffer", noremap = true, silent = true })
  end,
}

return plugin
