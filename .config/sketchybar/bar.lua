local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = true,
	height = 30,
	color = colors.bar.bg,
	padding_right = 6,
	padding_left = 6,
	shadow = true,
})
