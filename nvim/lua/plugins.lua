return {
	"nvim-lua/plenary.nvim",
	"folke/neodev.nvim",
	"folke/which-key.nvim",
	"nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
	"folke/neoconf.nvim",
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	"felipeagc/fleet-theme-nvim",
	"vim-airline/vim-airline",
	"vim-airline/vim-airline-themes",
	{
	    "lukas-reineke/indent-blankline.nvim",
	    main = "ibl",
	    opts = {},
	},
	"nvim-neo-tree/neo-tree.nvim",
	"antosha417/nvim-lsp-file-operations",
	{
	  "s1n7ax/nvim-window-picker",
	  version = "2.*",
	  config = function()
	    require("window-picker").setup({
	      filter_rules = {
	        include_current_win = false,
	        autoselect_one = true,
	        -- filter using buffer options
	        bo = {
	          -- if the file type is one of following, the window will be ignored
	          filetype = { "neo-tree", "neo-tree-popup", "notify" },
	          -- if the buffer type is one of following, the window will be ignored
	          buftype = { "terminal", "quickfix" },
	        },
	      },
	    })
	  end,
	},
	"mason-org/mason.nvim",
	"mason-org/mason-lspconfig.nvim",
	"nvim-treesitter/nvim-treesitter",
	{
	  "folke/trouble.nvim",
	  opts = {}, -- for default options, refer to the configuration section for custom setup.
	  cmd = "Trouble",
	  keys = {
	    {
	      "<leader>xx",
	      "<cmd>Trouble diagnostics toggle<cr>",
	      desc = "Diagnostics (Trouble)",
	    },
	    {
	      "<leader>xX",
	      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	      desc = "Buffer Diagnostics (Trouble)",
	    },
	    {
	      "<leader>cs",
	      "<cmd>Trouble symbols toggle focus=false<cr>",
	      desc = "Symbols (Trouble)",
	    },
	    {
	      "<leader>cl",
	      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	      desc = "LSP Definitions / references / ... (Trouble)",
	    },
	    {
	      "<leader>xL",
	      "<cmd>Trouble loclist toggle<cr>",
	      desc = "Location List (Trouble)",
	    },
	    {
	      "<leader>xQ",
	      "<cmd>Trouble qflist toggle<cr>",
	      desc = "Quickfix List (Trouble)",
	    },
	  },
	},
	"sindrets/diffview.nvim",
	{
	    'dnlhc/glance.nvim',
	    cmd = 'Glance'
	},
	{
	    'nvim-telescope/telescope.nvim', version = '*',
	    dependencies = {
	        'nvim-lua/plenary.nvim',
	        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	    }
	},
	{
	  "neovim/nvim-lspconfig",
	  config = function()
	    vim.lsp.config("*", {})
	    vim.lsp.enable({
	      "pyright",
	      "eslint",
	      "clangd",
	      "lua_ls",
	      "html",
	      "cssls",
	      "ts_ls",
	      "basedpyright",
	      "quick-lint-js",
	      "ast-grep",
	    })
	  end
	},
}
