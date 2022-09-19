-- https://github.com/CRAG666/code_runner.nvim
require('code_runner').setup {
    -- put here the commands by filetype
    filetype = {
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt && rm $fileNameWithoutExt.class",
        c = "cd $dir && gcc $fileName -Wall -g3 -o $fileNameWithoutExt && ./$fileNameWithoutExt && rm -f $fileNameWithoutExt",
        cpp = "cd $dir && g++ $fileName -Wall -g3 -o $fileNameWithoutExt && ./$fileNameWithoutExt && rm -f $fileNameWithoutExt",
        python = "python3 -u",
        typescript = "deno run",
        rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
        lua = function()
            vim.cmd "w | source $MYVIMRC | source %"
        end,
        markdown = function ()
            vim.cmd "FloatermNew --autoclose=0 --height=0.9 --width=0.9 glow %"
        end
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
        height = 1,
        width = 0.5,
        x = 1,
        y = 0,
        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",
        -- Transparency (see ':h winblend')
        blend = 0,
    },
    project = {
    --     ["~/deno/example"] = {
    --         name = "ExapleDeno",
    --         description = "Project with deno using other command",
    --         file_name = "http/main.ts",
    --         command = "deno run --allow-net"
    --     },
    --     ["~/cpp/example"] = {
    --         name = "ExapleCpp",
    --         description = "Project with make file",
    --         command = "make buid & cd buid/ & ./compiled_file"
    --     }
    },
}
