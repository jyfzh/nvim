vim.o.laststatus = 3

local statusline_augroup = vim.api.nvim_create_augroup("native_statusline", { clear = true })

-- LSP clients attached to buffer
local function lsp_clients()
    local current_buf = vim.api.nvim_get_current_buf()

    local clients = vim.lsp.get_clients({ bufnr = current_buf })
    if next(clients) == nil then
        return ""
    end

    local c = {}
    for _, client in pairs(clients) do
        table.insert(c, client.name)
    end
    return " 󰌘 " .. table.concat(c, "|")
end
--- @return string
local function filename()
    local fname = vim.fn.expand("%:t")
    if fname == "" then
        return ""
    end
    return fname .. " "
end

--- @param severity integer
--- @return integer
local function get_lsp_diagnostics_count(severity)
    if not rawget(vim, "lsp") then
        return 0
    end

    local count = vim.diagnostic.count(0, { serverity = severity })[severity]
    if count == nil then
        return 0
    end

    return count
end

--- @param type string
--- @return integer
local function get_git_diff(type)
    local gsd = vim.b.gitsigns_status_dict
    if gsd and gsd[type] then
        return gsd[type]
    end

    return 0
end

local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}
--- @return string
local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

--- @return string
local function python_env()
    if not rawget(vim, "lsp") then
        return ""
    end

    local buf = vim.api.nvim_get_current_buf()
    local buf_clients = vim.lsp.get_clients({ bufnr = buf })
    if next(buf_clients) == nil then
        return ""
    end

    for _, client in pairs(buf_clients) do
        if client.name == "pyright" or client.name == "pylance" then
            local virtual_env = os.getenv("VIRTUAL_ENV_PROMPT")
            if virtual_env == nil then
                return ""
            end

            virtual_env = virtual_env:gsub("%s+", "")
            return string.format("%%#StatusLineMedium# %s%%*", virtual_env)
        end
    end

    return ""
end

--- @return string
local function lsp_active()
    if not rawget(vim, "lsp") then
        return ""
    end

    local current_buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = current_buf })

    local space = "%#StatusLineMedium# %*"

    if #clients > 0 then
        return space .. "%#StatusLineLspActive#%*" .. space .. "%#StatusLineMedium#LSP%*"
    end

    return ""
end

--- @return string
local function diagnostics_error()
    local count = get_lsp_diagnostics_count(vim.diagnostic.severity.ERROR)
    if count > 0 then
        return string.format("%%#StatusLineLspError#  %s%%*", count)
    end

    return ""
end

--- @return string
local function diagnostics_warns()
    local count = get_lsp_diagnostics_count(vim.diagnostic.severity.WARN)
    if count > 0 then
        return string.format("%%#StatusLineLspWarn#  %s%%*", count)
    end

    return ""
end

--- @return string
local function diagnostics_hint()
    local count = get_lsp_diagnostics_count(vim.diagnostic.severity.HINT)
    if count > 0 then
        return string.format("%%#StatusLineLspHint#  %s%%*", count)
    end

    return ""
end

--- @return string
local function diagnostics_info()
    local count = get_lsp_diagnostics_count(vim.diagnostic.severity.INFO)
    if count > 0 then
        return string.format("%%#StatusLineLspInfo#  %s%%*", count)
    end

    return ""
end

--- @class LspProgress
--- @field client vim.lsp.Client?
--- @field kind string?
--- @field title string?
--- @field percentage integer?
--- @field message string?
local lsp_progress = {
    client = nil,
    kind = nil,
    title = nil,
    percentage = nil,
    message = nil,
}

vim.api.nvim_create_autocmd("LspProgress", {
    group = statusline_augroup,
    desc = "Update LSP progress in statusline",
    pattern = { "begin", "report", "end" },
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end

        lsp_progress = {
            client = vim.lsp.get_client_by_id(args.data.client_id),
            kind = args.data.params.value.kind,
            message = args.data.params.value.message,
            percentage = args.data.params.value.percentage,
            title = args.data.params.value.title,
        }

        if lsp_progress.kind == "end" then
            lsp_progress.title = nil
            vim.defer_fn(function()
                vim.cmd.redrawstatus()
            end, 500)
        else
            vim.cmd.redrawstatus()
        end
    end,
})

--- @return string
local function lsp_status()
    if not rawget(vim, "lsp") then
        return ""
    end

    if vim.o.columns < 120 then
        return ""
    end

    if not lsp_progress.client or not lsp_progress.title then
        return ""
    end

    local title = lsp_progress.title or ""
    local percentage = (lsp_progress.percentage and (lsp_progress.percentage .. "%%")) or ""
    local message = lsp_progress.message or ""

    local lsp_message = string.format("%s", title)

    if message ~= "" then
        lsp_message = string.format("%s %s", lsp_message, message)
    end

    if percentage ~= "" then
        lsp_message = string.format("%s %s", lsp_message, percentage)
    end

    return string.format("%%#StatusLineLspMessages#%s%%* ", lsp_message)
end

--- @return string
local function git_branch()
    local space = "%#StatusLineMedium# %*"
    local branch = vim.b.gitsigns_head

    if branch == "" or branch == nil then
        return ""
    end

    return "%#StatusLineGitBranchIcon#%*" .. space .. string.format("%%#StatusLineMedium#%s%%*", branch)
end

--- @return string
local function git()
    local full = ""
    local space = "%#StatusLineMedium# %*"

    local branch = git_branch()
    if branch ~= "" then
        full = full .. space .. branch .. space .. vim.b.gitsigns_status
    end

    return full
end

--- @return string
local function file_percentage()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)

    return string.format("%%#StatusLineMedium#  %d%%%% %%*", math.ceil(current_line / lines * 100))
end

--- @param hlgroup string
local function formatted_filetype(hlgroup)
    local filetype = vim.bo.filetype or vim.fn.expand("%:e", false)
    return string.format("%%#%s# %s %%*", hlgroup, filetype)
end

StatusLine = {}

StatusLine.inactive = function()
    return table.concat({
        formatted_filetype("StatusLineMode"),
    })
end

local redeable_filetypes = {
    ["qf"] = true,
    ["help"] = true,
    ["tsplayground"] = true,
}

StatusLine.active = function()
    local mode_str = vim.api.nvim_get_mode().mode
    if mode_str == "t" or mode_str == "nt" then
        return table.concat({
            mode(),
            "%=",
            "%=",
            file_percentage(),
        })
    end

    if redeable_filetypes[vim.bo.filetype] or vim.o.modifiable == false then
        return table.concat({
            formatted_filetype("StatusLineMode"),
            "%=",
            "%=",
            file_percentage(),
        })
    end

    local statusline = {
        -- mode(),
        -- filename(),
        git(),
        diagnostics_error(),
        diagnostics_warns(),
        diagnostics_hint(),
        diagnostics_info(),
        "%=",
        "%=",
        "%S ",
        lsp_status(),
        -- lsp_active(),
        python_env(),
        lsp_clients(),
        file_percentage(),
    }

    return table.concat(statusline)
end

vim.opt.statusline = "%!v:lua.StatusLine.active()"

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
    group = statusline_augroup,
    pattern = {
        "NvimTree_1",
        "NvimTree",
        "TelescopePrompt",
        "fzf",
        "lspinfo",
        "lazy",
        "netrw",
        "mason",
        "noice",
        "qf",
    },
    callback = function()
        vim.opt_local.statusline = "%!v:lua.StatusLine.inactive()"
    end,
})
