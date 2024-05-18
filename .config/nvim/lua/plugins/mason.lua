return {
	{
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonUpdate",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		event = "LazyFile",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {},
			inlay_hints = { enabled = true },
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {},
		config = function(_, opts)
			local mdap = require("mason-nvim-dap")
			mdap.setup(vim.tbl_deep_extend("force", opts, {
				handlers = { mdap.default_setup },
			}))
		end,
	},
}

