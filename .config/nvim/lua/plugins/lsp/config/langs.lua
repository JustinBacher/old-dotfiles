return {
        dockerls = {},
        html = {},
        jsonls = {},
        lua_ls = {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                client.server_capabilities.document_formatting = false
                client.server_capabilities.document_range_formatting = false
            end,
            settings = {
                Lua = {
                    hint = { enable = true },
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    telemetry = { enable = false },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        },
                    },
                },
            },
        },
        pylsp = {},
        rust_analyzer = {},
        tailwindcss = {},
        terraformls = {},
        tflint = {},
        tsserver = {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                client.server_capabilities.document_formatting = true
            end,
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            },
            init_options = { hostInfo = "neovim" },
            -- root_dir = util.root_pattern("package.json", "package-lock.json", "tsconfig.json", "jsconfig.json", ".git"),
            root_dir = function() return require("lspconfig.util").find_node_modules_ancestor end,
            single_file_support = true,
        },
        yamlls = {},
    },
}