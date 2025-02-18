return {
    {
        "catppuccin/nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        name = "catppuccin",
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = false,
            -- dim_inactive = {
            --     enabled = true,
            --     shade = "dark",
            --     percentage = 0.15,
            -- },
            integrations = {
                cmp = true,
                fidget = true,
                gitsigns = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
                telescope = true,
                treesitter = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme "catppuccin"
        end
    },
}
