require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.g.airline_powerline_fonts = 0
vim.g.webdevicons_enable_nerdtree = 1

vim.diagnostic.config({
  virtual_text = true,  -- Disable inline virtual text if it's cluttering
  signs = false,          -- Show signs in the sign column (default: E, W, H, I)
  underline = true,      -- Underline problematic lines
  update_in_insert = false,
  severity_sort = true,
})

vim.opt.termguicolors = true

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require("lsp-file-operations").setup()

require('neo-tree').setup({
	close_if_last_window = true;
})
vim.keymap.set('n', '<leader>nn', '<CMD>Neotree<CR>')

vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')

if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h10"
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_short_animation_length = 0
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_scroll_animation_length = 0
end

if vim.g.vscode then
	vim.g.airline_enabled = 0
	vim.cmd("AirlineToggle")
end
vim.cmd("colorscheme fleet")
