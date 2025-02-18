local key_file_path = vim.fn.stdpath('config') .. '/intelephense-license'
local f = io.open(key_file_path, 'r')

if f ~= nil then
    f:close()
    return
end

vim.notify("Decrypting intelephense license key", vim.log.levels.INFO)

vim.system(
    { "gpg", "--decrypt", "--output", key_file_path, key_file_path .. ".asc" },
    { text = true },
    function(out)
        if out.code ~= 0 then
            print("Failed to decrypt intelephense key: " .. out.stderr)
        end
    end
)
