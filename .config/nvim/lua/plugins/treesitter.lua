return {
	"nvim-treesitter/nvim-treesitter",
	version = "*",
	event = "LazyFile",
	build = ":TSUpdate",
	config = function()
		--- @diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
			sync_install = false,
			-- indent = { enable = true },
			highlight = { enabled = false },
			additional_vim_regex_highlighting = false,
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then return true end
			end,
		})
	end,
}
