return {
    {
        "ggandor/leap.nvim",
        init = function()
            local leap = require("leap")
            leap.create_default_mappings()
            leap.setup({
                next_target = "<enter>"
                prev_target = "<S-enter>"
                next_group = "<tab>"
                prev_group = "<S-tab>"
            })
        end,
    },
    {
        "ggandor/flit.nvim"
        init = function()
            require("flit").setup {
                keys = { f = "f", F = "F", t = "t", T = "T" },
                labeled_modes = "nv",
                multiline = true,
                -- Like `leap`s similar argument (call-specific overrides).
                -- E.g.: opts = { equivalence_classes = {} }
                opts = {}
              }
        end,
    }
}