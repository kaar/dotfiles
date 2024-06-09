-- Install package manager (https://github.com/folke/lazy.nvim)
-- See `:help lazy.nvim.txt`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- This loads all the plugins directly from ./user/plugins/*
-- Took inspiration from https://github.com/tjdevries/config.nvim
require("lazy").setup(
  { import = "user/plugins" },
  {
    change_detection = {
      notify = true,
    }
  }
)
