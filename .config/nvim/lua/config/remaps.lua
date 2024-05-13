local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return {
	-- Global ease of use
	{ "<leader>qq", "<cmd>qa<cr>", desc = "Quit All Buffers" },
	{ "<leader>qw", "<cmd>wq<cr>", desc = "Write current buffer and Quit" },
	{ "<leader>l", "<cmd>Lazy<cr>", desc = "Open Lazy" },
	{ "<leader>w", "<cmd>w<cr><esc>", desc = "Write file" },

	-- Movement
	{ "J", "<C-d>zz", desc = "Move up half page" },
	{ "K", "<C-u>zz", desc = "Move up half page" },
	{ "H", "^", desc = "Easier goto beginning of line" },
	{ "L", "$", desc = "Easier goto end of line" },

	-- Moving lines
	{ "<A-J>", "<cmd>m .+1<cr>==", desc = "Move Line Down" },
	{ "<A-K>", "<cmd>m .-2<cr>==", desc = "Move Line Up" },
	{ "<A-J>", "<esc><cmd>m .+1<cr>==gi", mode = "i", desc = "Move Line Down" },
	{ "<A-K>", "<esc><cmd>m .-2<cr>==gi", mode = "i", desc = "Move Line Up" },
	{ "<A-J>", ":m '>+1<cr>gv=gv", mode = "v", desc = "Move Line Down" },
	{ "<A-K>", ":m '<-2<cr>gv=gv", mode = "v", desc = "Move Line Up" },

	-- Tabs
	{ "<Tab>", "<cmd>bnext<cr>", desc = "Next Tab" },
 { "<S-Tab>", "<cmd>bprevious<cr>", desc = "Previous Tab" },

-- Windows
 { "<leader>wd", "<C-W>c", desc = "Delete Window", remap = true },
 { "<leader>wj", "<C-W>s", desc = "Split Window Below", remap = true },
 { "<leader>wl", "<C-W>v", desc = "Split Window Right", remap = true },
 { "<leader>wrh", "<cmd>vertical resize -5", desc = "Resize Window Up" },
 { "<leader>wrj", "<cmd>resize +5", desc = "Resize Window Down" },

-- Diagnostics
 { "<leader>dd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
 { "<leader>dj", diagnostic_goto(true), desc = "Next Diagnostic" },
 { "<leader>dk", diagnostic_goto(false), desc = "Prev Diagnostic" },

	-- Miscellaneous
 { "<leader>ll", "<cmd>lopen<cr>", desc = "Location List" },
 { "<leader>qf", "<cmd>copen<cr>", desc = "Quickfix List" },
	{ "U", "<C-r>", desc = "Redo" },
	{ "<esc>", "<cmd>noh<cr><esc>", desc = "Escape and Clear hlsearch" },
}
