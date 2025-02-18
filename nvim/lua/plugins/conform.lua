return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            javascript = { "prettierd", stop_after_first = true },
            typescript = { "prettierd", stop_after_first = true },
            typescriptreact = { "prettierd", stop_after_first = true },
            svelte = { "prettierd", stop_after_first = true },
            php = { "easy-coding-standard" }
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
