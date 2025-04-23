return {
    "williamboman/mason.nvim",
    dependencies = "williamboman/mason-lspconfig.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonUninstallAll", "MasonLog" },
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
        github = {
            download_url_template = "https://github.com/%s/releases/download/%s/%s",
        },
    }
}
