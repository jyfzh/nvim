-- https://github.com/williamboman/nvim-lsp-installer
local lsp_installer_servers = require("nvim-lsp-installer.servers")
-- WARN: 手动书写 LSP 配置文件
-- 名称：https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- 配置：https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
    -- 语言服务器名称：配置选项
    sumneko_lua = require("lsp.sumneko_lua"),
	require("lsp.clangd"),
	require("lsp.jdtls"),
    -- pyright = require("lsp.pyright"),
    -- tsserver = require("lsp.tsserver"),
    -- html = require("lsp.html"),
    -- cssls = require("lsp.cssls"),
    -- gopls = require("lsp.gopls"),
    -- jsonls = require("lsp.jsonls"),
    -- zeta_note = require("lsp.zeta_note"),
    -- sqls = require("lsp.sqls"),
    -- vuels = require("lsp.vuels")
}

-- 这里是 LSP 服务启动后的按键加载
-- local function attach(_, bufnr)
-- end
--
-- 自动安装或启动 LanguageServers
for server_name, server_options in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    -- 判断服务是否可用
    if server_available then
        -- 判断服务是否准备就绪，若就绪则启动服务
        server:on_ready(
            function()
                -- keybind
                server_options.on_attach = attach
                -- options config
                server_options.flags = {
                    debounce_text_changes = 150
                }
				-- 代替内置 omnifunc
				server_options.capabilities = capabilities
                -- 启动服务
                server:setup(server_options)
            end
        )
        --[[ 如果服务器没有下载，则通过 notify 插件弹出下载提示
        if not server:is_installed() then
            vim.notify("Install Language Server : " .. server_name, "WARN", {title = "Language Servers"})
            server:install()
        end]]
    end
end
