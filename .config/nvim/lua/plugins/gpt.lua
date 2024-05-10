return {
    "olimorris/codecompanion.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional
      {
        "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
        lazy = true,
        opts = {
          adapters = {
            ollama = "ollama",
          },
          strategies = {
            chat = "ollama",
            inline = "ollama",
          },
        },
      },
    },
    init = function()
      vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })

      -- Expand `cc` into CodeCompanion in the command line
      vim.cmd([[cab cc CodeCompanion]])
    end,
    config = true,
  }

--[[return {
    "huynle/ogpt.nvim",
    event = "VeryLazy",
    opts = {
        default_provider = "ollama",
        providers = {
            ollama = {
                api_host = os.getenv("OLLAMA_API_HOST") or "http://localhost:11434",
                api_key = os.getenv("OLLAMA_API_KEY") or "",
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
}
]]--