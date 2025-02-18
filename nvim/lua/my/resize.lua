local M = {}

M.resize = function(vertical, margin)
    local cur_win = vim.api.nvim_get_current_win()

    vim.cmd(string.format("wincmd %s", vertical and "l" or "j"))
    local new_win = vim.api.nvim_get_current_win()

    local sign = margin > 0
    if not (new_win == cur_win) then
        vim.cmd "wincmd p"
    else
        sign = not sign
    end

    sign = sign and "+" or "-"
    local dir = vertical and "vertical " or ""
    local cmd = dir .. "resize " .. sign .. math.abs(margin) .. "<CR>"
    vim.cmd(cmd)
end

return M
