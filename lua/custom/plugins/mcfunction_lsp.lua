---@diagnostic disable-next-line: undefined-global
local client = vim.lsp.start_client {
  name = 'mcfunction_lsp',
  cmd = { '/home/main/public/git/local/mend.d/mcfunction-lsp/dev/dist/lsp', '--verbose' },
  root_dir = vim.fn.getcwd(),
}

if not client then
  vim.notify 'MCFunction LSP Client did not load!'
end

vim.filetype.add {
  extension = {
    mcfunction = 'mcfunction',
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'mcfunction',
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end,
})

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.mcfunction = {
  install_info = {
    url = '/home/main/.local/share/nvim/tree-sitter-mcfunction', -- local path or git repo
    files = { 'src/parser.c' }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    --     branch = "main", -- default branch in case of git repo if different from master
    --         generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    --               },
    filetype = 'mcfunction', -- if filetype does not match the parser name
    --                 }
  },
}

return {}
