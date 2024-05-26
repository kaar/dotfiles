-- See `:help telescope` and `:help telescope.setup()`
local keymap = vim.keymap.set

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')

keymap('n', '<leader>f', builtin.find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
keymap('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
keymap('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
keymap('n', '<leader>st', builtin.live_grep, { desc = '[S]earch [T]ext' })
keymap('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
