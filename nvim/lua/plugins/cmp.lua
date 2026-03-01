return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "onsails/lspkind.nvim",
            { "nvim-tree/nvim-web-devicons", lazy = true },
        },
        config = function()
            local cmp = require "cmp"
            local lspkind = require "lspkind"
            local luasnip = require "luasnip"

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4, { "i", "c" })),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4, { "i", "c" })),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete {}, { "i", "c" }),
                    ["<C-c>"] = cmp.mapping.close(),
                    ["<C-y>"] = cmp.mapping.confirm { select = true },
                    -- ["<C-l>"] = cmp.mapping(function()
                    --     if luasnip.expand_or_locally_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     end
                    -- end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" })
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "vim-dadbod-completion" },
                }),
                formatting = {
                    format = lspkind.cmp_format(),
                },
            }

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end
    },
}
