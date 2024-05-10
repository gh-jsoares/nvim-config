return {
    {
        "Shatur/neovim-ayu",
        config = function()
            require("ayu").setup({
                mirage = false
            })
        end,
        init = function()
            local colors = require("ayu.colors")

            vim.cmd.colorscheme("ayu")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "LineNr", { fg = colors.comment })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    }
}
