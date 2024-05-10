return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            },
            numhl = false,
            linehl = false,
            current_line_blame = true,
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
        })

        vim.keymap.set("n", "<leader>glb", ":Gitsigns blame_line<CR>", { desc = "Toggle current line blame" })
        vim.keymap.set("n", "<leader>]g", ":Gitsigns next_hunk<CR>", { desc = "Navigate to next git hunk" })
        vim.keymap.set("n", "<leader>[g", ":Gitsigns prev_hunk<CR>", { desc = "Navigate to prev git hunk" })
    end
}
