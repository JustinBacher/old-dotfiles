return {
	"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		init = function()
			vim.api.nvim_create_autocmd('BufReadPost', {
					group = vim.api.nvim_create_augroup('treesitter', {}),
					callback = function(ev)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
					vim.treesitter.start(ev.buf)
				end,
		})
	end,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
			sync_install = false,
			auto_install = true,
			highlight = { enabled = false },
			additional_vim_regex_highlighting = false,
		})
	end,
}
