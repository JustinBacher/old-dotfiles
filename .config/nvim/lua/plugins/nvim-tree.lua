local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
	"nvim-tree/nvim-tree.lua",
	version = false,
	lazy = next(vim.fn.argv()) == nil, ---@diagnostic disable-line: param-type-mismatch
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		local api = require("nvim-tree.api")
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Make tree close if last buffer
		vim.api.nvim_create_autocmd("QuitPre", { callback = function() vim.cmd("NvimTreeClose") end })

		-- If no editable buffer on open then open the tree
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function(data)
				if vim.fn.filereadable(data.file) == 1 and data.file == "" and vim.bo[data.buf].buftype == "" then
					api.toggle({ focus = false, find_file = true })
				end
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
			width = function() return math.floor(vim.opt.columns:get() * WIDTH_RATIO) end,
		},
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")
			api.config.mappings.default_on_attach(bufnr)

			local function map(key, op, desc)
				vim.keymap.set(
					"n",
					key,
					op,
					{ desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				)
			end

			map("<BS>", api.tree.change_root_to_parent, "Up")
			map("?", api.tree.toggle_help, "Help")
			map("h", api.tree.close, "Close")
			map("H", api.tree.collapse_all, "Collapse All")
			map("l", function()
				if api.tree.get_node_under_cursor().nodes ~= nil then
					api.node.open.edit()
				else
					api.node.open.edit()
					api.tree.close()
				end
			end, "Edit Or Open")
			map("L", function()
				if api.tree.get_node_under_cursor().nodes ~= nil then
					api.node.open.edit()
				else
					api.node.open.vertical()
				end
				api.tree.focus()
			end, "Vsplit Preview")
		end,
	},
}
