-- [[ Remember last cursor position ]]
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 1 and last_pos <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
      -- Center the screen
      vim.cmd("normal zz")
    end
  end
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Reset cursor ]]
-- Reset the cursor shape by briefly toggling insert mode when nvim starts.
local group = vim.api.nvim_create_augroup("reset_cursor_shape", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  pattern = "*",
  callback = function()
    vim.cmd("normal! :startinsert :stopinsert")
    vim.cmd("redraw!")
  end
})

