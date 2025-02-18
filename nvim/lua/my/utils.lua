local M = {}

M.nmap = function(lhs, rhs, desc, buffer)
    vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = buffer })
end

M.imap = function(lhs, rhs, desc, buffer)
    vim.keymap.set("i", lhs, rhs, { desc = desc, buffer = buffer })
end

M.vmap = function(lhs, rhs, desc, buffer)
    vim.keymap.set("v", lhs, rhs, { desc = desc, buffer = buffer })
end

M.tmap = function(lhs, rhs, desc, buffer)
    vim.keymap.set("t", lhs, rhs, { desc = desc, buffer = buffer })
end

M.winmove = function(key)
    local curwin = vim.fn.winnr()

    vim.cmd("wincmd " .. key)

    if curwin == vim.fn.winnr() then
        if key == "j" or key == "k" then
            vim.cmd "wincmd s"
        else
            vim.cmd "wincmd v"
        end

        vim.cmd("wincmd " .. key)
    end
end

return M
