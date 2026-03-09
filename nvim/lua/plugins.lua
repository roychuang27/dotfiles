return {
  "nvim-lua/plenary.nvim",
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/nui.nvim",
  "folke/neoconf.nvim",
  "folke/snacks.nvim",
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
          bo = {
            -- ignore certain filetypes
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            -- ignore certain buffer types
            buftype = { "terminal", "quickfix" },
          },
        },
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  "mason-org/mason-lspconfig.nvim",
  "nvim-treesitter/nvim-treesitter",
  {
      "HiPhish/rainbow-delimiters.nvim",
      config = function()
        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = 'rainbow-delimiters.strategy.global',
                vim = 'rainbow-delimiters.strategy.local',
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            priority = {
                [''] = 110,
                lua = 210,
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        }
      end
  },
  {
    "folke/trouble.nvim",
    opts = {},
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
    "dnlhc/glance.nvim",
    cmd = "Glance",
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  "nvim-telescope/telescope-project.nvim",
  {
      'A7lavinraj/assistant.nvim',
      branch = 'stable',
      lazy = false,
      keys = {
          { '<leader>a', '<cmd>Assistant<cr>', desc = 'Assistant.nvim' }
      },
      opts = {},
  },
  "terrortylor/nvim-comment",
  "nvim-telescope/telescope-ui-select.nvim",
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end
  },
  {
      "FotiadisM/tabset.nvim",
      config = function()
          require("tabset").setup({
              defaults = {
                  tabwidth = 8,
                  expandtab = true
              },
              languages = {
                  lua = {
                      tabwidth = 4,
                      expandtab = true
                  },
                  python = {
                      tabwidth = 4,
                      expandtab = true
                  },
                  {
                      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml" },
                      config = {
                          tabwidth = 4
                      }
                  }
              }
          })
      end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "saadparwaiz1/cmp_luasnip" },
    config = function()
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      
      cmp.setup({
        -- completion = {
        --   autocomplete = false,
        -- },
        snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = {
          -- ['<CR>'] = cmp.mapping(function(fallback)
          --      if cmp.visible() then
          --          if luasnip.expandable() then
          --              luasnip.expand()
          --          else
          --              cmp.confirm({
          --                  select = true,
          --              })
          --          end
          --      else
          --          fallback()
          --      end
          -- end),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        })
      })
    end,
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
    end,
  },
}
