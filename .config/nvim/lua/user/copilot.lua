local keymap = vim.keymap.set

vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

vim.g.copilot_no_tab_map = true
keymap('i', '<C-E>', 'copilot#Accept("<CR>")', {
  expr = true,
  replace_keycodes = false
})
