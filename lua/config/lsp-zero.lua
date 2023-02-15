local M = {}

function M.setup()
  local lsp = require("lsp-zero")

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


  lsp.ensure_installed({
    'tsserver',
    'eslint',
  })
  lsp.nvim_workspace()

  lsp.setup()
end

return M
