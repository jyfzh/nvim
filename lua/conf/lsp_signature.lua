-- https://github.com/ray-x/lsp_signature.nvim
require("lsp_signature").setup(
    {
        bind = true,
        -- 边框样式
        handler_opts = {
            -- double、rounded、single、shadow、none
            border = "single"
        },
        -- 自动触发
        floating_window = true,
        -- 虚拟提示关闭
        hint_enable = true,
		hint_prefix = "🖐️",
        -- 正在输入的参数将如何突出显示
        hi_parameter = "LspSignatureActiveParameter"
    }
)
