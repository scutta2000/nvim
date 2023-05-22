local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = { window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    l = {
      name = "Language protocol",
      f = { "<Plug>(coc-codeaction)", "Fix" },
      j = { "<Plug>(coc-definition)", "Jump to definition" },
      p = {":LspZeroFormat<Cr>", "Format code"},
      i = {":OrganizeImports<Cr>", "Organize imports"},
      r = { "<Plug>(coc-rename)", "Rename symbol" }
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
      d = { "<cmd>DiffviewOpen<CR>", "Diff" },
    },

    o = {
      name = "Open",
      f = { "<cmd>Telescope find_files <cr>", "File" },
      F = { "<cmd>Telescope live_grep <cr>", "File" },
      t = { "<cmd>NvimTreeToggle<cr>", "File tree" },
      T = { "<cmd>NvimTreeFindFile<cr>", "File tree" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
