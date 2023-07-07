require('plugins')
require('keymaps')

-- 
-- Settings
--
vim.g.mapleader = " "
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.mouse = 'a'
vim.opt.laststatus= 2
vim.opt.wrap = true
vim.loader.enable()

-- vim.cmd([[
-- set spell
-- ]])

--
-- Configuration
--

vim.opt.termguicolors = true
vim.cmd('colorscheme nord')


--Pretty Status bar
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'nord',
	},
}

-- Add Ctrl + X and initialize toggle term 
require("toggleterm").setup {
	open_mapping = [[<c-x>]],
	shade_terminals = false
}

-- Add projects capability to telescope
require('telescope').load_extension('projects')
require'telescope'.setup({
    defaults = {
        file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/", "%.jpg", "%.png" },
    }
})

-- Add indentBlankline
vim.opt.list = true,
-- vim.opt.listchars:append "space:⋅"

require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}



-- LSP and Linting Config
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
    'bashls',
    'luau_lsp',
    'marksman',
    'powershell_es',
  },
	automatic_installation = true,
})

-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

-- File Explorer nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

