local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
	"nvim-tree/nvim-tree.lua",
	version = false,
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.api.nvim_create_autocmd("BufEnter", {
			nested = true,
			callback = function()
				if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
					vim.cmd("quit")
				end
			end,
		})
		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			callback = function(data)
				local real_file = vim.fn.filereadable(data.file) == 1
				local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
				if not real_file and not no_name then
					return
				end
				require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
			end,
		})
	end,
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Open File Tree" },
	},
	opts = {
		view = {
			float = {
				enable = true,
				open_win_config = function()
					local screen_w = vim.opt.columns:get()
					local window_w = screen_w * WIDTH_RATIO
					local window_h = (vim.opt.lines:get() - vim.opt.cmdheight:get()) * HEIGHT_RATIO
					return {
						border = "rounded",
						relative = "editor",
						row = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get(),
						col = (screen_w - window_w) / 2,
						width = math.floor(window_w),
						height = math.floor(window_h),
					}
				end,
			},
			width = function()
				return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
			end,
		},
	},
}
