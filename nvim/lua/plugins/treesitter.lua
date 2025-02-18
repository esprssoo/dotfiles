return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = 'main',
        build = ":TSUpdate",
        init = function()
            -- main branch stores queries in runtime/ subdirectory
            local path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
            vim.opt.runtimepath:prepend(path)
        end,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                branch = 'main'
            }
        },
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "php" },
            },
            indent = {
                enable = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ia"] = "@parameter.inner",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>@"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    goto_next_start = {
                        ["]]"] = "@function.outer",
                    },
                    goto_next_end = {
                        ["]["] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[["] = "@function.outer",
                    },
                    goto_previous_end = {
                        ["[]"] = "@function.outer",
                    },
                },
            },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
}
