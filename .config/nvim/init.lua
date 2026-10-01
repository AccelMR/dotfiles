vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      require "configs.dap"
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },

    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  -- CMake integration with target/build-type selection and debug support
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "mfussenegger/nvim-dap" }, -- required for debugging targets
    cmd = {
      "CMakeGenerate", "CMakeBuild", "CMakeRun", "CMakeDebug", "CMakeSelectBuildType", "CMakeSelectLaunchTarget",
    },
    config = function()
      require("cmake-tools").setup({
        cmake_build_directory = "build/${variant:buildType}", -- e.g. build-Debug, build-Release
        cmake_compile_command_options ={
          action = "soft_link"
        }, -- keep compile_commands.json symlinked for clangd
      })
    end,
  },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

require("cpp_settings").setup()
