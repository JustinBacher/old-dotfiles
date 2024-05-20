return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = "LazyFile",
	lazy = vim.fn.argc(-1) == 0,
	main = "nvim-treesitter.configs",
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	--- @diagnostic disable-next-line: missing-fields
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		},
		auto_install = true,
		sync_install = true,
		indent = { enable = true },
		highlight = { enable = false },
		disable = function(lang, buf) ---@diagnostic disable-line: unused-local
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			return ok and stats and stats.size > 100 * 1024 -- 100kb
		end,
		additional_vim_regex_highlighting = false,
	},
}
