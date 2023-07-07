local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer has ended, Reopen Neovim..."
  cmd [[packadd packer.nvim]]
end

-- Rerun PackerCompile everytime pluggins.lua is updated
cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Installing pluggins
return packer.startup(function(use)
    use { "wbthomason/packer.nvim"} -- Have packer manage itself
    use { "nvim-lua/plenary.nvim"} -- Useful lua functions used by lots of plugins

    -- Comment Plugin use gc or gb in visual mode
	use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup {} end
	}

    use { "kyazdani42/nvim-web-devicons"}
    use { "kyazdani42/nvim-tree.lua"}
    use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

    -- Terminal Toggle
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
		end
	}
    -- Use Ctrl+fp to list recent git projects
	use { 
		"ahmedkhalf/project.nvim",
    config = function() require("project_nvim").setup {} end
	}

    -- alpha dashboard
    use {
			'goolord/alpha-nvim',
			requires = { 'kyazdani42/nvim-web-devicons' },
			config = function ()
					require'alpha'.setup(require'alpha.themes.startify'.config)
			end
	}

    use { "lukas-reineke/indent-blankline.nvim"} -- smarter indent

    -- Colorschemes
    use { "lunarvim/darkplus.nvim"}
    use { "arcticicestudio/nord-vim"}

    -- Telescope
    use { "nvim-telescope/telescope.nvim"}
    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter"}

    -- Git
    use { "lewis6991/gitsigns.nvim"}

    -- LSP and Linting
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
        -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
