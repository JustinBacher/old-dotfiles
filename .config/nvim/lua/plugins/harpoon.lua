return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon: Mark File" },
      { "<C-e>", function() local h = require("harpoon") h.ui:toggle_quick_menu(h:list()) end, desc = "Toggle Harpoon Menu" },
      { "<C-t>", function() require("harpoon"):list():select(1) end, desc = "Harpoon File 1" },
      { "<C-s>", function() require("harpoon"):list():select(2) end, desc = "Harpoon File 2" },
      { "<C-b>", function() require("harpoon"):list():select(3) end, desc = "Harpoon File 3" },
      { "<C-g>", function() require("harpoon"):list():select(4) end, desc = "Harpoon File 4" },
  }
}
