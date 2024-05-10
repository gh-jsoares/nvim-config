return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" }, -- NEW TO SETUP
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lua" },

        -- Useful status updates for LSP
        { "j-hui/fidget.nvim" },

        -- Additional lua configuration, makes nvim stuff amazing
        { "folke/neodev.nvim" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
    },
    config = function()
        require("neodev").setup({})

        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
            'tsserver',
            'lua_ls',
            'rust_analyzer',
        })

        -- Fix Undefined global 'vim'
        lsp.configure('lua_ls', {
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    },
                }
            }
        })

        local cmp = require('cmp')
        lsp.setup_nvim_cmp({
            sources = {
                { name = 'nvim_lsp_signature_help' },
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete({}),
        })

        cmp_mappings['<Tab>'] = nil
        cmp_mappings['<S-Tab>'] = nil

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        --[[
        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            }
        })
        ]]

        lsp.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }

            local add_desc = function(desc)
                local new_opts = vim.deepcopy(opts)
                new_opts.desc = desc
                return new_opts
            end

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, add_desc("Go to definition"))
            vim.keymap.set("n", "<leader>t", vim.lsp.buf.type_definition, add_desc("View type definition"))
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
        end)

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
