require ("user.keymaps")
require ("user.lazy")
require ("user.launch")
require ("user.options")
require ("user.telescope")
require ("user.treesitter")
require ("user.lsp")
require ("user.copilot")

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

-- -- Keymaps for better default experience
-- -- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--
-- -- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
