local M = {}

function M.setup()
  local lsp = require("lsp-zero")

  lsp.setup_servers({
    'tsserver',
    'eslint',
    'clangd',
    'nil_ls',
    'tailwindcss',
    'ocamllsp',
    'pyright',
  })

  local function organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = ""
    }
    vim.lsp.buf.execute_command(params)
  end

  lsp.preset("recommended")

  lsp.configure('tsserver', {
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports"
      }
    }

  })


  lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({
      preserve_mappings = false
    })

    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
  end)

  local lua_opts = lsp.nvim_lua_ls()
  require('lspconfig').lua_ls.setup(lua_opts)

  local cmp = require('cmp')

  cmp.setup({
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
    }
  })


  lsp.setup()
end

return M
