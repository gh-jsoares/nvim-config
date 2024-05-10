return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "Shatur/neovim-ayu",
    },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = false,
                theme = "ayu",
                component_separators = "|",
                section_separators = "",
            },
        })
    end
}

