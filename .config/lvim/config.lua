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
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Cycle buffer
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

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
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
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

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "isort", filetype = { "python" } },
  { exe = "black", filetype = { "python" } },
  {
    exe = "prettier",
    filetypes = { "javascript", "typescript", "css", "html", "yaml" },
    args = { "--print-width 180", "--single-quote", "--trailing-comma", "none" },
  },
}
-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { exe = "flake8", filetypes = { "python" }, args = { "--max-line-length=120" } },
  { exe = "shellcheck", filetypes = { "sh", "bash" }, args = { "--severity", "warning" } },
  { exe = "codespell", filetypes = { "javascript", "python" }, args = { "--ignore-words", "spell/en.utf-8.add" } },
  { exe = "eslint", filetypes = { "javascript", "typescript" } },
  -- { exe = "pylint", filetypes = { "python" } },
}

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  { "sainnhe/gruvbox-material" },
  { "tpope/vim-fugitive" },
  { "github/copilot.vim" },
  { "christoomey/vim-tmux-navigator" },
  { "farmergreg/vim-lastplace" },
  { "arcticicestudio/nord-vim" },
  { "hashivim/vim-terraform" },
  { "preservim/vimux" },
  { "vim-test/vim-test" },
  { "skywind3000/asyncrun.vim" },
  { "tpope/vim-dispatch" },
  { "hkupty/iron.nvim" },
  { "geg2102/nvim-python-repl" },
  { "tpope/vim-rhubarb" },
  {
    "samueljoli/hurl.nvim",
    config = function()
      require('hurl').setup(
      )
    end,
  }
}

-- https://github.com/LunarVim/LunarVim/issues/1856
-- configure copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

local cmp = require "cmp"

lvim.keys.insert_mode["<C-e>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
