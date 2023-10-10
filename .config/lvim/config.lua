--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
lvim.format_on_save = {
  enabled = true,
  pattern = "*.py",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Cycle buffer
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-t>"] = ":GPT<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "gruvbox-material"

-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- -see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`

-- DISABLE pyright
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "jedi_language_server"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
--
--

-- -- add `pyright` to `skipped_servers` list
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- -- remove `pyre` from `skipped_servers` list
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "pyre"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- Remeber last cursor position
vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
]]

-- Wrap Markdown
-- vim.cmd [[
--   autocmd BufReadPre *.md setlocal textwidth=80 | setlocal wrap
-- ]]

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "isort", filetype = { "python" } },
  { exe = "black", filetype = { "python" } },
  -- { exe = "codespell", filetype = { "python" } },
  -- { exe = "prettier", filetype = { "javascript", "typescript", "css", "html", "yaml" } },
  -- { exe = "shfmt", filetype = { "sh", "bash" } },
  -- { exe = "ruff",  filetype = { "python" } },
  {
    exe = "prettier",
    filetypes = { "javascript", "typescript", "css", "html", "yaml" },
    args = { "--print-width 180", "--single-quote", "--trailing-comma", "none" },
  },
  { exe = "sqlformat", filetypes = { "sql" }, args = { "--reindent", "--keywords upper" } }
}
-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { exe = "flake8",     filetypes = { "python" },                                 args = { "--max-line-length=120" } },
  { exe = "shellcheck", filetypes = { "sh", "bash" },                             args = { "--severity", "warning" } },
  { exe = "codespell",  filetypes = { "tex", "markdown", "python", "javascript" } },
  -- args = { "--ignore-words", "spell/en.utf-8.add" } },
  { exe = "eslint",     filetypes = { "javascript", "typescript" } },
  { exe = "ruff",       filetypes = { "python" } },
  -- { exe = "pylint",     filetypes = { "python" } },
}

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  { "sainnhe/gruvbox-material" },
  { "tpope/vim-fugitive" },
  { "github/copilot.vim" },
  { "christoomey/vim-tmux-navigator" },
  -- { "farmergreg/vim-lastplace" },
  -- { "arcticicestudio/nord-vim" },
  -- { "hashivim/vim-terraform" },
  -- { "preservim/vimux" },
  -- { "vim-test/vim-test" },
  -- { "skywind3000/asyncrun.vim" },
  -- { "tpope/vim-dispatch" },
  -- { "hkupty/iron.nvim" },
  -- { "geg2102/nvim-python-repl" },
  -- { "tpope/vim-rhubarb" },
  -- {
  --   "samueljoli/hurl.nvim",
  --   config = function()
  --     require('hurl').setup(
  --     )
  --   end,
  -- }
}

-- https://github.com/LunarVim/LunarVim/issues/1856
-- configure copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""


-- vim.g.copilot_node_command = "~/.config/nvm/versions/node/v20.2.0/bin/node"
vim.g.copilot_node_command = "~/.config/lvim/log-node.sh"
--
-- d
-- let g:copilot_node_command =
--      \ "~/.nodenv/versions/16.15.0/bin/node"


--
-- let g:copilot_node_command =
--       \ "~/.nodenv/versions/16.15.0/bin/node"

local cmp = require "cmp"

-- <M-]> Cycle to the next suggestion, if one is available.
-- <M-[> Cycle to the previous suggestion.
lvim.keys.insert_mode["<C-e>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end






-- -- Create a custom debugging buffer
-- function create_debug_buffer()
--   local buf = vim.api.nvim_create_buf(false, true)
--   local win = vim.api.nvim_open_win(buf, true, {
--     relative = 'editor',
--     width = vim.o.columns,
--     height = vim.o.lines // 4,
--     row = vim.o.lines - vim.o.lines // 4,
--     col = 0,
--     style = 'minimal'
--   })
--   vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
--   vim.api.nvim_win_set_option(win, 'wrap', false)
--   vim.api.nvim_win_set_option(win, 'cursorline', true)
--   return buf
-- end
--
-- -- Write a message to the debugging buffer
-- function debug_message(msg)
--   local debug_buf = create_debug_buffer()
--   vim.api.nvim_buf_set_lines(debug_buf, -1, -1, false, {msg})
-- end
--
function create_scratch_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = vim.o.columns,
    height = vim.o.lines / 4,
    row = vim.o.lines - vim.o.lines / 4,
    col = 0,
    style = "minimal",
  })
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_win_set_option(win, "wrap", false)
  vim.api.nvim_win_set_option(win, "cursorline", true)
  return buf
end

function write_to_scratch_buffer(msg)
  local scratch_buf = create_scratch_buffer()
  vim.api.nvim_buf_set_lines(scratch_buf, -1, -1, false, { msg })
end

function gpt_open()
  -- local text = "Hello from Lua function 3!"
  -- print(text)

  -- local text = vim.api.nvim_get_current_line()
  -- -- send to gpt
  -- print(text)
  -- print(text)
  -- print(text)
  -- print(text)
  -- print(text)
  -- print(text)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "test", "text" })
  -- vim.api.nvim_buf_set_name(buf, "gpt")

  local opts = {
    relative = "editor",
    width = 200,
    height = 2,
    row = 1,
    col = 10,
    anchor = "NW",
    style = "minimal",
  }

  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
  -- local buf = nvim_create_buf(v:false, v:true)
  -- call nvim_buf_set_lines(buf, 0, -1, v:true, ["test", "text"])
  -- let opts = {'relative': 'cursor', 'width': 10, 'height': 2, 'col': 0,
  --     \ 'row': 1, 'anchor': 'NW', 'style': 'minimal'}
  -- let win = nvim_open_win(buf, 0, opts)
  -- " optional: change highlight, otherwise Pmenu is used
  -- call nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
end

vim.api.nvim_create_user_command("GPT", function(opts)
  -- require("neoai").smart_toggle(opts.args)
  -- gpt_open()
  write_to_scratch_buffer("Hello from Lua function 3!")
end, {
  nargs = "*",
})

lvim.keys.normal_mode["<leader>t"] = ":GPT<CR>"



-- function MyFunction(arg)
--   -- local result = {}
--   -- for word in string.gmatch(arg, "%S+") do
--   --   table.insert(result, string.upper(string.sub(word, 1, 1)) .. string.sub(word, 2))
--   -- end
--   -- return table.concat(result, " ")
--   print(arg)
-- end

-- vim.api.nvim_create_user_command('Prose', function()
--   -- print "Hello World"
--   print("Hello World")
-- end,
--   { nargs = 0, desc = 'Apply prose settings' }
-- )

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
