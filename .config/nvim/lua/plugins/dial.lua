return {
    {
        "monaqa/dial.nvim",
        keys = {
            { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end },
            { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end },
      },
}