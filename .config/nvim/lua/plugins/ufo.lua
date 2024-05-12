return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	init = function()
		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	keys = {
		{ "zR", "<cmd>require('ufo').openAllFolds<cr>", desc = "Open all folds" },
		{ "zM", "<cmd>require('ufo').closeAllFolds<cr>", desc = "Close all folds" },
		{
			"zK",
			function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end,
			desc = "Peek Fold",
		},
	},

	opts = {
		provider_selector = function(bufnr, filetype, buftype) ---@diagnostic disable-line: unused-local
			return { "lsp", "indent" }
		end,
	},
}
