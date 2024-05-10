require("config.lazy")

vim.keymap.set({ "n", "v" }, "<leader>qq", "<cmd>qa<cr>", {
	noremap = true,
	silent = true,
	nowait = true,
	desc = "Quit All Buffers",
})
vim.keymap.set({ "n", "v" }, "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Move down half page" })
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Move up half page" })
vim.keymap.set({ "n", "v" }, "<leader>w", "<cmd>w<cr><esc>", { desc = "Write file" })
