return {
    "nvim-lua/plenary.nvim",
    "folke/neodev.nvim",
    "folke/which-key.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "folke/neoconf.nvim",
    "folke/snacks.nvim",
    {
        "sainnhe/everforest",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("everforest")
        end,
    },
    {
        "vim-airline/vim-airline",
        config = function()
            if vim.g.vscode then
                vim.g.airline_enabled = 0
                vim.cmd("AirlineToggle")
            end
        end,
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("lualine").setup({
          options = {
            theme = "auto",
            globalstatus = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
          },
        })
      end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            if vim.g.vscode then
                require("ibl").setup({ enabled = false })
                return
            end
            require("ibl").setup({
              enabled = true,
              debounce = 200, -- optional; how often to refresh (ms)
              whitespace = {
                remove_blankline_trail = true,
              },
              scope = {
                enabled = false,
                show_start = true,
                show_end = false,
                show_exact_scope = false,
                injected_languages = true,
                include = {
                  node_type = {
                    python = {
                      "if_statement",
                      "for_statement",
                      "while_statement",
                      "function_definition",
                      "class_definition",
                      "with_statement",
                      "try_statement",
                    },
                  },
                },
              },
              exclude = {
                filetypes = {
                  "help",
                  "startify",
                  "dashboard",
                  "packer",
                  "neogitstatus",
                  "NvimTree",
                  "Trouble",
                },
                buftypes = { "terminal", "nofile" },
              },
            })
        end,
        dependencies = { "TheGLander/indent-rainbowline.nvim" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 35,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
            })
            vim.keymap.set("n", "<leader>nn", "<CMD>NvimTreeToggle<CR>")
        end,
    },
    {
        "antosha417/nvim-lsp-file-operations",
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
            require("window-picker").setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    bo = {
                        filetype = { "neo-tree", "neo-tree-popup", "notify" },
                        buftype = { "terminal", "quickfix" },
                    },
                },
            })
        end,
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            automatic_enable = true,
            ensure_installed = {
                "pyright",
                "eslint",
                "clangd",
                "lua_ls",
                "html",
                "cssls",
                "ts_ls",
                -- "basedpyright",
                "quick_lint_js",
                "ast_grep",
            }
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.install").install({
                "python",
                "c",
                "cpp",
                "javascript",
                "typescript",
                "tsx",
                "html",
                "css",
                "json",
                "lua",
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "python", "c", "cpp", "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css", "json", "lua" },
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = "rainbow-delimiters.strategy.global",
                    vim = "rainbow-delimiters.strategy.local",
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {
            modes = {
                diagnostics = {
                    mode = "diagnostics",
                    win = { type = "split" }
                },
            },
        },
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        },
    },
    "sindrets/diffview.nvim",
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-project.nvim",
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
            vim.keymap.set("n", "<leader>fr", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
            local telescope = require("telescope")
            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
            telescope.load_extension("project")
            vim.keymap.set("n", "<leader>fp", telescope.extensions.project.project)
        end,
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
        "A7lavinraj/assistant.nvim",
        branch = "stable",
        lazy = false,
        keys = {
            { "<leader>a", "<cmd>Assistant<cr>", desc = "Assistant.nvim" },
        },
        opts = {
            mappings = {},
            commands = {
                cpp = {
                    extension = 'cpp',
                    template = nil,
                    compile = {
                        main = 'g++',
                        args = { '$FILENAME_WITH_EXTENSION', '-DLOCAL', '-o', '/home/roychuang/tmp/$FILENAME_WITHOUT_EXTENSION.out' },
                    },
                    execute = {
                        main = '/home/roychuang/tmp/$FILENAME_WITHOUT_EXTENSION.out',
                        args = nil,
                    },
                },
                python = {
                    extension = 'py',
                    template = nil,
                    compile = nil,
                    execute = {
                        main = 'python3',
                        args = { '$FILENAME_WITH_EXTENSION' },
                    },
                },
            },
            ui = {
                border = 'single',
                diff_mode = true,
                title_components_separator = '',
            },
            core = {
                process_budget = 5000,
                port = 10043,
                filename_generator = nil
            },
        },
    },
    "terrortylor/nvim-comment",
    "nvim-telescope/telescope-ui-select.nvim",
    {
        "L3MON4D3/LuaSnip",
        config = function()
            local ls = require("luasnip")
            require("luasnip.loaders.from_snipmate").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load()
            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
        end,
    },
    {
        "rmagatti/goto-preview",
        dependencies = { "rmagatti/logger.nvim", "nvim-telescope/telescope.nvim" },
        config = function()
            require("goto-preview").setup({
                width = 120,
                height = 15,
                border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
                default_mappings = false,
                debug = false,
                opacity = nil,
                resizing_mappings = false,
                post_open_hook = nil,
                post_close_hook = nil,
                references = {
                    provider = "telescope",
                    telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
                },
                focus_on_open = true,
                dismiss_on_move = false,
                force_close = true,
                bufhidden = "wipe",
                stack_floating_preview_windows = true,
                same_file_float_preview = true,
                preview_window_title = { enable = true, position = "left" },
                zindex = 1,
                vim_ui_input = false,
            })
            local gpv = require("goto-preview")
            vim.keymap.set("n", "gpd", gpv.goto_preview_definition)
            vim.keymap.set("n", "gpt", gpv.goto_preview_type_definition)
            vim.keymap.set("n", "gpi", gpv.goto_preview_implementation)
            vim.keymap.set("n", "gpD", gpv.goto_preview_declaration)
            vim.keymap.set("n", "gP", gpv.close_all_win)
            vim.keymap.set("n", "gpr", gpv.goto_preview_references)
        end,
    },
    {
        "FotiadisM/tabset.nvim",
        config = function()
            require("tabset").setup({
                defaults = {
                    tabwidth = 8,
                    expandtab = true,
                },
                languages = {
                    lua = {
                        tabwidth = 4,
                        expandtab = true,
                    },
                    python = {
                        tabwidth = 4,
                        expandtab = true,
                    },
                    {
                        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml" },
                        config = {
                            tabwidth = 4,
                        },
                    },
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {},
                mapping = {
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end),
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
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
}
