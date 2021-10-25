local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then
        vim.cmd("packadd " .. plugin)
    end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(
    function(use)
        use { "wbthomason/packer.nvim" }
        use { "tpope/vim-fugitive", opt = true }
        use { "nvim-lua/plenary.nvim", opt = true }
        use { "arcticicestudio/nord-vim" }
        use { "kyazdani42/nvim-web-devicons", opt = true }
        use { "lewis6991/gitsigns.nvim", opt = true }

        require_plugin("nvim-web-devicons")
        require_plugin("vim-fugitive")
        require_plugin("gitsigns.nvim")
        require_plugin("plenary.nvim")
    end
)
