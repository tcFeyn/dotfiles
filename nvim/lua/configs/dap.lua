local dap = require('dap')

dap.adapters.python = {
  type = 'executable';
  command = '';
  args = { '-m', 'debugpy.adapter' };
}
