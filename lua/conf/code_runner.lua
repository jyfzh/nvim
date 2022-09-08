-- https://github.com/CRAG666/code_runner.nvim
-- https://github.com/arjunmahishi/run-code.nvim
require('code_runner').setup {
-- put here the commands by filetype
    filetype = {
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        cpp = "cd $dir && g++ $fileName -Wall -g3 -o $fileNameWithoutExt && ./$fileNameWithoutExt && rm $fileNameWithoutExt",
        python = "python3 -u",
        typescript = "deno run",
        rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
    },
    -- choose default mode (valid term, tab, float, toggle, buf)
    mode = 'float',
    -- Focus on runner window(only works on toggle, term and tab mode)
    focus = true,
    -- startinsert (see ':h inserting-ex')
    startinsert = true,
    term = {
        --  Position to open the terminal, this option is ignored if mode is tab
        position = "bot",
        -- window size, this option is ignored if tab is true
        size = 8,
    },
    float = {
        -- Window border (see ':h nvim_open_win')
        border = "single",

        -- Num from `0 - 1` for measurements
        height = 0.8,
        width = 0.5,
        x = 0.8,
        y = 0.3,

        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",

        -- Transparency (see ':h winblend')
        blend = 0,
    },
    project = {
        ["~/deno/example"] = {
            name = "ExapleDeno",
            description = "Project with deno using other command",
            file_name = "http/main.ts",
            command = "deno run --allow-net"
        },
        ["~/cpp/example"] = {
            name = "ExapleCpp",
            description = "Project with make file",
            command = "make buid & cd buid/ & ./compiled_file"
        }
    },
}
