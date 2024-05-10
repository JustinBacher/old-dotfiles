return {
	{
		"tzachar/cmp-ai",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			local cmp_ai = require("cmp_ai.config")

			cmp_ai:setup({
				provider = "Ollama",
				provider_options = {
					model = "codellama:7b-code",
				},
				notify = true,
				notify_callback = function(msg)
					vim.notify(msg)
				end,
				run_on_every_keystroke = true,
			})
		end,
	},
	{ "hrsh7th/nvim-cmp", dependencies = { "tzachar/cmp-ai" } },
}
