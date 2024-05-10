return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add current file to harpoon" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Toggle harpoon menu" })

        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Select harpoon file 1" })
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Select harpoon file 2" })
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Select harpoon file 3" })
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Select harpoon file 4" })
        vim.keymap.set("n", "<leader>!", function() harpoon:list():replace_at(1) end,
            { desc = "Replace harpoon file 1 with current file" })
        vim.keymap.set("n", "<leader>\"", function() harpoon:list():replace_at(2) end,
            { desc = "Replace harpoon file 2 with current file" })
        vim.keymap.set("n", "<leader>#", function() harpoon:list():replace_at(3) end,
            { desc = "Replace harpoon file 3 with current file" })
        vim.keymap.set("n", "<leader>$", function() harpoon:list():replace_at(4) end,
            { desc = "Replace harpoon file 4 with current file" })
    end
}

