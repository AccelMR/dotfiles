return {
  "folke/persistence.nvim",
  event = "VimEnter",
  opts = {
    branch = false, -- avoid embedding git branch name in session filename
  },
  config = function(_, opts)
    require("persistence").setup(opts)

    -- Close NvimTree before the session is saved on exit
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        local ok, api = pcall(require, "nvim-tree.api")
        if ok then
          api.tree.close()
        end
      end,
    })

    -- Restore session, deferred so NvChad finishes loading its base46 highlights first
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require("persistence").load()
      end)
    end

    -- After restoring: re-read only buffers with real files, reopen NvimTree
    vim.api.nvim_create_autocmd("SessionLoadPost", {
      callback = function()
        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local name = vim.api.nvim_buf_get_name(buf)
            if name ~= "" and vim.fn.filereadable(name) == 1 then
              vim.api.nvim_buf_call(buf, function()
                vim.cmd("e!")
              end)
            end
          end

          local ok, api = pcall(require, "nvim-tree.api")
          if ok then
            api.tree.open()
          end
        end)
      end,
    })
  end,
}
