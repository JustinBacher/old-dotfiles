return {
	"monaqa/dial.nvim",
	config = function()
		-- Don't know why I need to specify keymaps like this and not as lazy keys but meh whatever
		local dial_map = require("dial.map")
		local map = vim.keymap.set
		local opts = { silent = true }
		map("n", "<C-a>", dial_map.inc_normal(), opts)
		map("n", "<C-x>", dial_map.dec_normal(), opts)
		map("x", "<C-a>", dial_map.inc_visual(), opts)
		map("x", "<C-x>", dial_map.dec_visual(), opts)
		map("x", "g<C-a>", dial_map.inc_gvisual(), opts)
		map("x", "g<C-x>", dial_map.dec_gvisual(), opts)

		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.hex,
				augend.date.alias["%Y/%m/%d"],
				augend.date.alias["%Y-%m-%d"],
				augend.date.alias["%m/%d"],
				augend.date.alias["%H:%M"],
				augend.semver.alias.semver,
				augend.constant.alias.bool,
			},
		})
	end,
}
