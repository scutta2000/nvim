local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme
    use {
      "sainnhe/everforest",
      config = function()
        --vim.cmd "colorscheme everforest"
      end,
    }
    use {
      "AlexvZyl/nordic.nvim",
      config = function()
        vim.cmd "colorscheme nordic"
      end
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "NeogitOrg/neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }
    use { "tpope/vim-fugitive" }
    -- Gif diff
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end

    --WhichKey
    use {
      "folke/which-key.nvim",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    --Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    --LuaLine
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
        require("config.lualine").setup()
      end,
      requires = { "nvim-web-devicons" },
    }

    --See scope
    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
    }

    --Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
    }

    --Telescope
    use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
        require('telescope').setup({
          defaults = {
            file_ignore_patterns = { "node_modules", ".git/" },
          },
          pickers = {
            find_files = {
              hidden = true,
              --find_command = {"rg", "--no-ignore"}
            },
          },
        })
      end,
    }

    --File tree
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    --Leap
    use {
      "ggandor/leap.nvim",
      config = function()
        require("leap").set_default_keymaps(true)
      end,
    }


    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      wants = "nvim-treesitter",
      event = "InsertEnter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- Auto html tag
    use {
      "windwp/nvim-ts-autotag",
      wants = "nvim-treesitter",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- LSP and completion
    use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
      },
      config = function()
        require("config.lsp-zero").setup()
      end
    }

    ---Prettier
    use {
      'MunifTanjim/prettier.nvim',
      requires = {
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'neovim/nvim-lspconfig' }
      },
      congit = function()
        require("config.prettier").setup()
      end
    }

    -- Reize mode
    use { 'sedm0784/vim-resize-mode' }

    -- Code folding
    use {
      "kevinhwang91/nvim-ufo",
      opt = true,
      event = { "BufReadPre" },
      wants = { "promise-async" },
      requires = "kevinhwang91/promise-async",
      config = function()
        require("ufo").setup()

        vim.keymap.set("n", "zR", require("ufo").openAllFolds)
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      end,
    }


    -- Sticky function def
    use {
      'nvim-treesitter/nvim-treesitter-context',
      requires = {
        { 'nvim-treesitter/nvim-treesitter' }
      }
    }

  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
