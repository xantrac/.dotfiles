vim.cmd [[
    syntax on
    colorscheme nightfox
    filetype plugin indent on
]]

vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalMenu = 1

vim.g.mapleader = ","

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.showbreak = '+++'
vim.opt.textwidth = 100
vim.opt.showmatch = true
vim.opt.spell = false
vim.opt.visualbell = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.undolevels = 1000
vim.opt.clipboard = "unnamedplus"
vim.opt.virtualedit = "onemore"
vim.opt.list = true
vim.opt.lcs = "space:·"
vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.encoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"

vim.keymap.set('n', '<Leader>r', ':luafile ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<Leader>w', ':update<CR>')

vim.keymap.set('n', '<leader>n', ':NERDTreeFocus<CR>')
vim.keymap.set('n', '<C-b>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<C-n>', ':NERDTreeFind<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>cf', [[:let @* = expand("%:p")<CR>]], { noremap = true, silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('plugins')
require('lsp_config_file')
require('cmp_config')
require('colorizer_config')
require('treesitter')
require('lualine').setup {
    options = {
        theme = 'nightfox'
    }
}