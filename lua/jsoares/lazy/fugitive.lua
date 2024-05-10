return {
    "tpope/vim-fugitive",
    config = function()
        -- Keymap to open git status
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
    end
}

