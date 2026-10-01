local dap = require "dap"

local codelldb = vim.fn.stdpath("data")
  .. "/mason/packages/codelldb/extension/adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb,
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch C++ executable",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
