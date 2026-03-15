if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h11"
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

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

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
    virtual_text = true,
    signs = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.cmd([[nnoremap q: <nop>]])
