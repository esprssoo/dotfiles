return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        require "mini.statusline".setup()
        require "mini.surround".setup()
        require "mini.ai".setup()
    end
}
