local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use "lukas-reineke/cmp-rg"
    use "onsails/lspkind-nvim"
    use "windwp/nvim-ts-autotag"
    use 'norcalli/nvim-colorizer.lua'
    use "EdenEast/nightfox.nvim"
    use "preservim/nerdtree"
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lua/plenary.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-endwise'
    use 'tpope/vim-fugitive'
    use 'knsh14/vim-github-link'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'tpope/vim-commentary'
    use 'editorconfig/editorconfig-vim'
    use 'ryanoasis/vim-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                filetypes = {
                    ["*"] = true
                },
                server_opts_overrides = {
                    trace = "verbose",
                    settings = {
                        advanced = {
                            listCount = 10,         -- #completions for panel
                            inlineSuggestCount = 5, -- #completions for getCompletions
                        }
                    },
                },
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = false,
                },
            })
        end,
    }
    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use { 'junegunn/fzf.vim' }
    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end
    }
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })
end)
