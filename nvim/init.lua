--[[

Neovim Configuration

--]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.g.netrw_banner = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.fn.empty(vim.fn.glob(lazypath)) == 1 then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", { lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json" })

-- vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"
vim.opt.colorcolumn = { 100 }
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 2
vim.opt.cursorline = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.langmap =
"ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz"
vim.opt.list = true
vim.opt.listchars = {
    tab = "  ",
    trail = "·",
    extends = "❯",
    precedes = "❮",
}
vim.opt.number = true
vim.opt.path = ".,,**"
vim.opt.pumblend = 30
vim.opt.relativenumber = true
vim.opt.scrolloff = 6
vim.opt.selectmode = "mouse"
vim.opt.showbreak = "↪"
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true
vim.opt.updatetime = 750
vim.opt.wildignore = {
    "**/node_modules/**",
    "**/.git/**",
}
vim.opt.wrap = false
-- Indent Behavior
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.splitkeep = "screen"

require "my.keymaps"
require "my.lsp"

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})

vim.filetype.add({
    extension = {
        mdx = 'mdx'
    }
})

-- Enable treesitter

local fts = {
    "php",
    "javascript",
    "typescript",
    "lua",
    "go",
    "elixir",
    "html",
    "heex",
    "svelte",
    "markdown",
    "mdx",
}

vim.treesitter.language.register('markdown', 'mdx')

vim.api.nvim_create_autocmd('FileType', {
    pattern = fts,
    callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
