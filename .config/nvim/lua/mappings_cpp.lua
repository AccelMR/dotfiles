-- C/C++-only keymaps, loaded via autocmd based on filetype
local map = vim.keymap.set

-- Compile and run current C++ file
map("n", "<F5>", "<cmd>w<CR><cmd>!g++ -std=c++17 % -o %:r && ./%:r<CR>", {
  desc = "Compile and run current C++ file",
  buffer = true,
})

-- Switch between .cpp and .h/.hpp
map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<CR>", {
  desc = "Switch between .cpp and .h/.hpp",
  buffer = true,
})

-- Go to definition, but focus an already-open tab instead of opening a duplicate
local function go_to_definition()
  local params = vim.lsp.util.make_position_params(0, "utf-16")

  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      vim.notify("No definition found", vim.log.levels.WARN)
      return
    end

    -- result can be a single location or a list of locations
    local location = result[1] or result
    local uri = location.uri or location.targetUri
    local range = location.range or location.targetSelectionRange

    if not uri or not range then
      vim.notify("Could not resolve definition location", vim.log.levels.WARN)
      return
    end

    local filepath = vim.uri_to_fname(uri)
    local lnum = range.start.line + 1
    local col = range.start.character

    -- Check if the target file is already open in any tab/window
    for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
        local buf = vim.api.nvim_win_get_buf(win)
        local bufname = vim.api.nvim_buf_get_name(buf)

        if bufname == filepath then
          vim.api.nvim_set_current_tabpage(tabpage)
          vim.api.nvim_set_current_win(win)
          vim.api.nvim_win_set_cursor(win, { lnum, col })
          return
        end
      end
    end

    -- Not open anywhere yet, open it normally
    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
    vim.api.nvim_win_set_cursor(0, { lnum, col })
  end)
end

map("n", "<F12>", go_to_definition, {
  desc = "Go to definition and focus existing tab",
  buffer = true,
})

-- Additional LSP shortcuts, similar to other editors
map("n", "<S-F12>", vim.lsp.buf.references, {
  desc = "LSP References",
  buffer = true,
})

map("n", "<C-F12>", vim.lsp.buf.implementation, {
  desc = "LSP Implementation",
  buffer = true,
})

map("n", "<F2>", vim.lsp.buf.rename, {
  desc = "LSP Rename symbol",
  buffer = true,
})
