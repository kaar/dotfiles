-- https://github.com/github/zbirenbaum/copilot.lua
-- Accept: <C-e>
-- Open: <M-CR>
-- Jump to next: <M-]>
-- Jump to prev: <M-[>
return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			{ "hrsh7th/nvim-cmp" },
		},
		enabled = true,
		cmd = "Copilot",
		event = "InsertEnter",
		keymap = {
			jump_prev = "[[",
			jump_next = "]]",
			accept = "<CR>",
			refresh = "gr",
			open = "<M-CR>",
		},
		config = function()
			require("copilot").setup({
				-- Open panel with <M-CR> (Alt + Enter)
				panel = {
					enabled = true,
					auto_refresh = true,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<C-e>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
			})
		end,
	},
}
