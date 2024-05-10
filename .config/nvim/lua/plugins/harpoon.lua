return {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    keys = {
      { "<leader>a", require("harpoon.mark").add_file, { desc = "Harpoon: Mark File" } },
      { "<C-e>", require("harpoon.ui").toggle_quick_menu, { desc = "Toggle Harpoon Menu" } },
      { "<C-t>", function() require("harpoon.ui").nav_file(1) end, { desc = "Harpoon File 1" } },
      { "<C-s>", function() require("harpoon.ui").nav_file(2) end, { desc = "Harpoon File 2" } },
      { "<C-b>", function() require("harpoon.ui").nav_file(3) end, { desc = "Harpoon File 3" } },
      { "<C-g>", function() require("harpoon.ui").nav_file(4) end, { desc = "Harpoon File 4" } },
  }
}