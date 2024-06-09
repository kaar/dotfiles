return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup {
      columns = {
        "icon",
      },
      view_options = {
        show_hidden = true,
      },
      default_file_explorer = true,
    }
  end,
}
