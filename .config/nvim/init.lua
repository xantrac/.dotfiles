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


function RipgrepFzf(query, fullscreen)
    local command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    local initial_command = string.format(command_fmt, vim.fn.shellescape(query))
    local reload_command = string.format(command_fmt, '{q}')
    local spec = {
        options = { '--disabled', '--query', query, '--bind', 'change:reload:' .. reload_command }
    }
    local fzf_preview = vim.fn['fzf#vim#with_preview']
    local fzf_grep = vim.fn['fzf#vim#grep']
    fzf_grep(initial_command, 1, fzf_preview(spec, 'right', 'ctrl-/'), fullscreen)
end

vim.cmd([[command! -nargs=* -bang RG call v:lua.RipgrepFzf(<q-args>, <bang>0)]])

vim.keymap.set('n', '<leader>ff', ':GFiles<CR>')
vim.keymap.set('n', '<leader>fg', ':RG<CR>')
vim.keymap.set('n', '<leader>fb', ':Buffers<CR>')
vim.keymap.set('n', '<leader>fh', ':History<CR>')

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
