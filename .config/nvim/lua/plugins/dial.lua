return {
	"monaqa/dial.nvim",
	config = function()
		-- Don't know why I need to specify keymaps like this and not as lazy keys but meh whatever
		vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { silent = true })
		vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { silent = true })
		vim.keymap.set("x", "<C-a>", require("dial.map").inc_visual(), { silent = true })
		vim.keymap.set("x", "<C-x>", require("dial.map").dec_visual(), { silent = true })
		vim.keymap.set("x", "g<C-a>", require("dial.map").inc_gvisual(), { silent = true })
		vim.keymap.set("x", "g<C-x>", require("dial.map").dec_gvisual(), { silent = true })

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
