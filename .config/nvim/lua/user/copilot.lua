vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = false

vim.keymap.set('i', '<C-E>', 'copilot#Accept("<CR>")', {
  expr = true,
  replace_keycodes = false
})
