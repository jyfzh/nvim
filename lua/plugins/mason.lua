return {
    "williamboman/mason.nvim",
    dependencies = "williamboman/mason-lspconfig.nvim",
    lazy = true,
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
            -- The template URL to use when downloading assets from GitHub.
            -- The placeholders are the following (in order):
            -- 1. The repository (e.g. "rust-lang/rust-analyzer")
            -- 2. The release version (e.g. "v0.3.0")
            -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
            download_url_template = "https://mirror.ghproxy.com/https://github.com/%s/releases/download/%s/%s",
        },
    }
}
