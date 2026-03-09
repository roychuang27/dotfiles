if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h10"
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_short_animation_length = 0
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_scroll_animation_far_lines = 0   
end

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.wrap = false

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = true
vim.opt.softtabstop = 8

vim.g.airline_powerline_fonts = 0
vim.g.webdevicons_enable_nerdtree = 1

vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  extends = "❯",
  precedes = "❮",
}

vim.diagnostic.config({
  virtual_text = true,  -- Disable inline virtual text if it's cluttering
  signs = false,          -- Show signs in the sign column (default: E, W, H, I)
  underline = true,      -- Underline problematic lines
  update_in_insert = false,
  severity_sort = true,
})

vim.opt.termguicolors = true

require("config.lazy")

vim.opt.background = dark
vim.cmd("colorscheme fleet")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require("lsp-file-operations").setup()

require("neo-tree").setup({
	close_if_last_window = true,
})
vim.keymap.set('n', '<leader>nn', '<CMD>Neotree<CR>')

vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')

vim.keymap.set("n", "<leader>fr", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

require('telescope').load_extension('project')
vim.keymap.set("n", "<leader>fp", require('telescope').extensions.project.project)

require("luasnip.loaders.from_vscode").lazy_load()

-- local ls = require("luasnip")
--
-- vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

if vim.g.vscode then
	vim.g.airline_enabled = 0
	vim.cmd("AirlineToggle")
end
