-- local function config()
-- local lspconfig = require "lspconfig"

-- local capabilities = {}

-- local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
-- if has_cmp then
--     capabilities = cmp_lsp.default_capabilities()
-- end
--
-- local eslint = {
--     lintCommand = [[eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}]],
--     lintIgnoreExitCode = true,
--     lintStdin = true,
--     lintFormats = {
--         "%f(%l,%c): %tarning %m",
--         "%f(%l,%c): %rror %m",
--     },
--     lintSource = "eslint",
-- }

-- local shellcheck = {
--     lintCommand = "shellcheck -f gcc -x",
--     lintSource = "shellcheck",
--     lintFormats = {
--         "%f:%l:%c: %trror: %m",
--         "%f:%l:%c: %tarning: %m",
--         "%f:%l:%c: %tote: %m",
--     },
-- }
--
-- local servers = {
--     efm = {
--         filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "sh" },
--         init_options = { documentFormatting = true },
--         settings = {
--             rootMarkers = { ".git/" },
--             languages = {
--                 typescript = { eslint },
--                 typescriptreact = { eslint },
--                 javascript = { eslint },
--                 javascriptreact = { eslint },
--                 sh = { shellcheck },
--             },
--         },
--     },
--     rust_analyzer = {
--         assist = {
--             importGranularity = "module",
--             importPrefix = "self",
--         },
--         cargo = {
--             buildScripts = {
--                 enable = true,
--             },
--         },
--         procMacro = {
--             enable = true,
--         },
--     },
--     gleam = {},
--     denols = {
--         root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
--     },
--     zls = {},
--     bashls = {},
-- }
-- end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "folke/neodev.nvim", },
        config = function()
            require("neodev").setup()
        end,
    },
    {
        "j-hui/fidget.nvim",
        tag = "v1.5.0",
        opts = {
            progress = {
                display = {
                    progress_ttl = 2,
                },
            },
            notification = {
                override_vim_notify = true,
            },
        },
        event = "LspAttach"
    },
}
