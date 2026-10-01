return {
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
    config = function()
      local ccc = require("ccc")
      local mapping = ccc.mapping

      ccc.setup({
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
      })

      -- Open the color picker for the color under the cursor
      vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<CR>", {
        desc = "Open color picker",
      })

      -- Toggle color highlighting in the current buffer
      vim.keymap.set("n", "<leader>ch", "<cmd>CccHighlighterToggle<CR>", {
        desc = "Toggle color highlighting",
      })
    end,
  },
}
