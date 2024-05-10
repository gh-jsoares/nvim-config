return {
    "eandrju/cellular-automaton.nvim",
    config = function ()
        vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })
        vim.keymap.set("n", "<leader>ms", "<cmd>CellularAutomaton scramble<CR>", { desc = "Make it rain" })
        vim.keymap.set("n", "<leader>mg", "<cmd>CellularAutomaton game_of_life<CR>", { desc = "Make it rain" })
    end
}

