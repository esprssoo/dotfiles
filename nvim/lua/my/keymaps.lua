local M = {}

local resize = require("my.resize").resize
local utils = require "my.utils"
local nmap, imap, vmap, tmap = utils.nmap, utils.imap, utils.vmap, utils.tmap

-- Window splits
nmap("<C-J>", function() utils.winmove "j" end)
nmap("<C-K>", function() utils.winmove "k" end)
nmap("<C-L>", function() utils.winmove "l" end)
nmap("<C-H>", function() utils.winmove "h" end)
nmap("<C-Q>", vim.cmd.quit)

-- Resize splits
nmap("<A-Up>", function() resize(false, -2) end)
nmap("<A-Down>", function() resize(false, 2) end)
nmap("<A-Left>", function() resize(true, -2) end)
nmap("<A-Right>", function() resize(true, 2) end)

-- Easy move lines
nmap("<C-S-J>", ":m+<CR>==")
nmap("<C-S-K>", ":m-2<CR>==")
vmap("<C-S-J>", ":m '>+1<CR>gv=gv")
vmap("<C-S-K>", ":m '<-2<CR>gv=gv")

nmap("<Esc>", vim.cmd.nohl)
nmap("<Tab>", "<C-^>")
nmap("<C-i>", "<Tab>") -- Re-bind for jump list
nmap("<Leader>q", vim.diagnostic.setqflist, "set diagnostic to quickfix list")
nmap("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "previous diagnostic")
nmap("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "next diagnostic")
nmap("[t", vim.cmd.tabp, "previous tab")
nmap("]t", vim.cmd.tabn, "next tab")
nmap("<Leader>u", vim.cmd.UndotreeToggle, "undotree")

-- imap("<Tab>", require("my.tab").forwards)
-- imap("<S-Tab>", require("my.tab").backwards)

imap("jk", "<Esc>")
imap("<C-e>", "<Plug>(copilot-accept-line)")

vmap("<Leader>p", '"_dP')
vmap(">", ">gv")
vmap("<", "<gv")

tmap("<Esc><Esc>", "<C-\\><C-n>")

M.telescope_keymaps = function(fns)
    nmap("<C-p>", fns.project, "Find project files")
    nmap("<Leader>fn", fns.dotfiles, "Dotfiles")
    nmap("<Leader><C-p>", fns.builtin.git_files, "Find git files")
    nmap("<Leader>fg", fns.builtin.live_grep, "Live grep")
    nmap("<Leader>gs", fns.builtin.git_status, "Git status")
end

M.gitsigns_keymaps = function(bufnr)
    local gs = require "gitsigns"

    nmap("]c", function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            gs.nav_hunk('next')
        end)
        return "<Ignore>"
    end, "next hunk", bufnr)

    nmap("[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            gs.nav_hunk('prev')
        end)
        return "<Ignore>"
    end, "previous hunk", bufnr)
end

return M
