return {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local telescope = require "telescope"
        local builtin = require "telescope.builtin"

        telescope.setup {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        }

        local function project()
            local exclusions = {
                "**/.git/",
                "*.svg",
                "*.png",
                "*.jpg",
            }

            local find_command = { "fd", "--hidden", "-t", "f" }
            for _, value in ipairs(exclusions) do
                table.insert(find_command, "--exclude")
                table.insert(find_command, value)
            end

            builtin.find_files {
                find_command = find_command,
            }
        end

        local function dotfiles()
            builtin.git_files {
                shorten_path = true,
                prompt_title = " ~ dotfiles ~ ",
                cwd = vim.env.DOTFILES_DIRECTORY,
            }
        end

        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")

        require("my.keymaps").telescope_keymaps {
            project = project,
            dotfiles = dotfiles,
            builtin = builtin,
        }
    end
}
