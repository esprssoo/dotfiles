local M = {}

local ok, ts = pcall(require, "nvim-treesitter.ts_utils")

if not ok then
    vim.notify "my.tab requires nvim-treesitter to work"
end

local pairs = {
    ["("] = ")",
    ["{"] = "}",
    ["["] = "]",
    ["<"] = ">",
    ["'"] = "'",
    ['"'] = '"',
    ["`"] = "`",
}

local get_new_position = function(node, direction)
    local is_single_line = function()
        local row_start, _, row_end, _ = node:range()
        return row_start == row_end
    end

    local is_wrapped = function()
        local text = vim.treesitter.get_node_text(node, 0)
        local first = string.sub(text, 1, 1)
        local last = string.sub(text, -1)
        return pairs[first] == last
    end

    if is_wrapped() and is_single_line() then
        if direction == "backward" then
            return node:start()
        end
        return node:end_()
    end
end

--- @param direction string The direction of the tab ('forward' | 'backward')
--- @return nil
M.tab = function(direction)
    -- Normal tab action
    local tab_action
    if direction == "forward" then
        tab_action = function()
            local codes = vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
            vim.api.nvim_call_function("feedkeys", { codes, "n" })
        end
    else
        tab_action = function()
            local codes = vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
            vim.api.nvim_call_function("feedkeys", { codes, "n" })
        end
    end

    local node = ts.get_node_at_cursor()

    if not node or not node:parent() then
        return tab_action()
    end

    local line, col = get_new_position(node, direction)

    if not line then
        return tab_action()
    end

    vim.api.nvim_win_set_cursor(0, { line + 1, col })
end

M.forwards = function()
    M.tab "forward"
end

M.backwards = function()
    M.tab "backward"
end

return M
