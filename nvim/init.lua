-- Main Neovim config entry point

-- Load core config modules
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Setup plugin management with lazy.vim
local layzypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(layzypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		layzypath,
	})
end
vim.opt.rtp:prepend(layzypath)

-- Configure plugings
require("lazy").setup({
	-- First load nvim-cmp for autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	require("plugins.lsp"),
	require("plugins.completion"),
	require("plugins.telescope"),
	-- Theme (catppuccin)
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"python",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"json",
					"yaml",
					"toml",
					"markdown",
					"sql",
					"bash",
					"dockerfile",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	-- UI improvements
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin-mocha",
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	require("plugins.formatting"),
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local keymaps (which-key)",
		},
	},
	"LazyVim/LazyVim",
	optional = true,
	opts = {
		format = { enabled = true },
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		local registry = require("mason-registry")
		local function ensure_installed()
			for _, tool in ipairs({
				"stylua",
				"prettier",
				"isort",
				"black",
				"prettierd",
			}) do
				if not registry.is_installed(tool) then
					vim.cmd("MasonInstall " .. tool)
				end
			end
		end

		if registry.refresh then
			registry.refresh(ensure_installed)
		else
			ensure_installed()
		end
	end,
})
