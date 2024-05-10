local presenting = false
local presentation_border = false

function TogglePresentationBorder()
    presentation_border = not presentation_border

    if presentation_border then
        vim.cmd("set cc=120")
    elseif presenting then
        vim.cmd("set cc=0")
    else
        vim.cmd("set cc=80")
    end
end

function TogglePresentation()
    presentation_border= false

    if not presenting then
        presenting = true

        vim.cmd("set nornu nonu nosmd nosc hid noru ls=0 cc=0 scl=no")
        require("lualine").hide({ unhide = false })

        vim.keymap.set("n", "<Left>", vim.cmd.bp, { silent = true, desc = "Previous slide" })
        vim.keymap.set("n", "<Right>", vim.cmd.bn, { silent = true, desc = "Next slide" })

        vim.keymap.set("n", "<Home>", vim.cmd.bf, { silent = true, desc = "First slide" })
        vim.keymap.set("n", "<End>", vim.cmd.bl, { silent = true, desc = "Last slide" })
    else
        presenting = false

        vim.cmd("set rnu nu smd sc nohid ru ls=2 cc=80 scl=yes")
        require("lualine").hide({ unhide = true })

        vim.keymap.del("n", "<Left>")
        vim.keymap.del("n", "<Right>")
        vim.keymap.del("n", "<Home>")
        vim.keymap.del("n", "<End>")
    end
end

vim.keymap.set("n", "<F5>", TogglePresentation, { desc = "Toggle presentation mode" })
vim.keymap.set("n", "<F6>", TogglePresentationBorder, { desc = "Toggle presentation border" })

-- Ascii art binds
vim.keymap.set({ "n", "v" }, "<leader>F", ":.!toilet -w 200 -f standard<CR>", { desc = "Transform into large text" })
vim.keymap.set({ "n", "v" }, "<leader>f", ":.!toilet -w 200 -f small<CR>", { desc = "Transform into small text" })
vim.keymap.set({ "n", "v" }, "<leader>b", ":.!toilet -w 200 -f term -F border<CR>", { desc = "Add border around text" })
vim.keymap.set({ "n", "v" }, "<leader>c", ":center 120<CR>", { desc = "Center text" })

-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--     pattern = {"*.vpm"},
--     callback = function(_)
--         vim.cmd("source syntax.vim")
--     end
-- })
