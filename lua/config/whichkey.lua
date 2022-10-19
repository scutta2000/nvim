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
    ["q"] = { "<cmd>bd<CR>", "Quit" },
 
    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    l = {
      name = "Language protocol",
      f = {"<Plug>(coc-codeaction)", "Fix"},
      j = {"<Plug>(coc-definition)", "Jump to definition"}, 
      p = {":CocCommand prettier.formatFile<Cr>", "Prettier format"}
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
    },

    o = {
      name = "Open",
      f = {"<cmd>Telescope find_files hidden=true no-ignore-vcs=true <cr>", "File"},
      F = {"<cmd>Telescope live_grep <cr>", "File"},
      t = { "<cmd>NvimTreeToggle<cr>", "File tree" },
      b = {"<cmd>Telescope buffers<cr>", "Buffers"},
    },
  }
 
  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
