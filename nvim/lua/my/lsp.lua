vim.lsp.config.svelte = {}
vim.lsp.config.gopls = {}
vim.lsp.config.ts_ls = {}

vim.lsp.config.expert = {
    cmd = { vim.fn.expand '$HOME/.local/bin/expert', "--stdio" },
    root_markers = { 'mix.exs', '.git' },
    filetypes = { 'elixir', 'eelixir', 'heex' },
}

vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

vim.lsp.config.intelephense = {
    init_options = { licenceKey = vim.fn.stdpath("config") .. "/intelephense-license" },
    settings = {
        intelephense = {
            files = { maxSize = 1000000000 },
            format = { enable = false },
            stubs = require "intelephense_stubs",
        },
    },
}

vim.lsp.config.nixd = {
    settings = {
        formatting = {
            command = { "nixfmt" },
        },
    },
}

vim.lsp.enable { 'expert', 'lua_ls', 'svelte', 'intelephense', 'nixd', 'gopls', 'ts_ls' }

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then
            return
        end

        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold" }, {
                callback = vim.lsp.buf.document_highlight,
                buffer = args.buf,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                callback = vim.lsp.buf.clear_references,
                buffer = args.buf,
            })
        end
    end,
})
