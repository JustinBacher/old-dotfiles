local map = LazyVim.safe_keymap_set
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
