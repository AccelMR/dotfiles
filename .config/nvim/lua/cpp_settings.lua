local M = {}

function M.setup()
  local line_limit_group = vim.api.nvim_create_augroup(
    "CAndCppLineLimits",
    { clear = true }
  )

  vim.api.nvim_create_autocmd("FileType", {
    group = line_limit_group,
    pattern = { "c", "cpp" },
    callback = function()
      -- Load C/C++-specific keymaps
      require "mappings_cpp"

      -- Display continuous guides at columns 80 and 95
      vim.opt_local.colorcolumn = "80,95"

      -- Use a vivid pink background for both guides
      vim.api.nvim_set_hl(0, "ColorColumn", {
        bg = "#d160c8",
      })

      -- Use spaces instead of tabs
      vim.opt_local.expandtab = true
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
      vim.opt_local.softtabstop = 4

      -- Show whitespace characters visually
      vim.opt_local.list = true
      vim.opt_local.listchars = {
        tab = "»·",
        space = "·",
        trail = "·",
      }
    end,
  })
end

return M
