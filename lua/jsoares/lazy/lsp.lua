return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- LSP Support
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Completion
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lua",


        -- Additional lua configuration, makes nvim stuff amazing
        "folke/neodev.nvim",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",

        -- Useful status updates for LSP
        "j-hui/fidget.nvim",
    },

    config = function()
        require("neodev").setup({})

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "tsserver",
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "eslint@4.8.0" -- Use version 4.8.0 -> Newer versions are broken
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,


                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                                completion = {
                                    CallSnippet = "Replace",
                                },
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        local cmp_mappings = cmp.mapping({
            ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        })

        cmp_mappings["<Tab>"] = nil
        cmp_mappings["<S-Tab>"] = nil

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp_mappings,
            sources = cmp.config.sources({
                { name = "nvim_lsp_signature_help" },
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            virtual_text = {
                prefix = "",
                spacing = 4,
            },
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('LspAttachConfig', { clear = true }),
            callback = function(event)
                local opts = { buffer = event.buf, remap = false }

                local add_desc = function(desc)
                    local new_opts = vim.deepcopy(opts)
                    new_opts.desc = desc
                    return new_opts
                end

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, add_desc("Go to definition"))
                vim.keymap.set("n", "<leader>vt", vim.lsp.buf.type_definition, add_desc("View type definition"))
                vim.keymap.set("n", "K", vim.lsp.buf.hover, add_desc("Show signature help"))
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, add_desc("Search workspace symbols"))
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, add_desc("Open diagnostic float"))
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, add_desc("Open diagnostic quickfix list"))
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, add_desc("Go to next diagnostic"))
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, add_desc("Go to previous diagnostic"))
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, add_desc("Code action"))
                vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references, add_desc("Find references"))
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, add_desc("Rename symbol"))
                vim.keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help, add_desc("Show signature help"))
            end
        })
    end
}
