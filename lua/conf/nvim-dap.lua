local dap = require('dap')

require("dap.cpptools")
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/jyf/.local/share/nvim/dap/cpptools/extension/debugAdapters/bin/OpenDebugAD7'
}

local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end


