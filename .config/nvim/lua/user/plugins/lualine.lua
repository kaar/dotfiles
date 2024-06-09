-- Lualine
-- See :help lualine
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = false,
      theme = "gruvbox",
      component_separators = "|",
      section_separators = "",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
