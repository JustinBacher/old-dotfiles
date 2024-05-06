return {
    {
        "ggandor/leap.nvim",
        depenencies = { "tpope/vim-repeat" },
        opts = {
            next_target = "<enter>"
            prev_target = "<S-enter>"
            next_group = "<tab>"
            prev_group = "<S-tab>"
        },
    },
    {
        "ggandor/flit.nvim"
        dependencies = { "ggandor/leap.nvim", "tpope/vim-repeat" },
        opts = {
            keys = { f = "f", F = "F", t = "t", T = "T" },
            labeled_modes = "nv",
            multiline = true
        }
    }
}