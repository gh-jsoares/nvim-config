return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("trouble").setup({
            icons = false,
        })

        vim.keymap.set("n", "<leader>tt", function()
            require("trouble").toggle()
        end, { desc = "Toggle trouble window (diagnostics across project)" })

        vim.keymap.set("n", "[t", function()
            require("trouble").next({ skip_groups = true, jump = true });
        end, { desc = "Next trouble item" })

        vim.keymap.set("n", "]t", function()
            require("trouble").previous({ skip_groups = true, jump = true });
        end, { desc = "Previous trouble item" })
    end
}
