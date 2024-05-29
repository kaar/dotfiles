-- This extension is used to execute a selected query in the current buffer
-- and display the output in a new buffer
--
-- Usage:
-- 1. Select the query you want to execute
-- 2. Press <leader>e

local function show_output(output)
  -- TODO
  -- Check if output is empty
  -- Format output
  -- Open in a temporary buffer
  -- Select the buffer
  local tempfile = vim.fn.tempname() .. ".sqls_output"
  local bufnr = vim.fn.bufnr(tempfile, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, vim.split(output, "\n"))
  vim.cmd(("%s pedit %s"):format("", tempfile))
  vim.api.nvim_set_option_value("filetype", "sqls_output", { buf = bufnr })
end

local function selected_text()
  local region = vim.region(0, "'<", "'>", vim.fn.visualmode(), true)
  local text = ""
  local maxcol = vim.v.maxcol
  for line, cols in vim.spairs(region) do
    local endcol = cols[2] == maxcol and -1 or cols[2]
    local chunk = vim.api.nvim_buf_get_text(0, line, cols[1], line, endcol, {})[1]
    text = ("%s%s\n"):format(text, chunk)
  end
  return text
end

local function execute_query(query)
  -- TODO:
  -- Sanity check query
  vim.fn.setenv("PGCONNECT_TIMEOUT", "2")
  local psql_command = os.getenv("NVIM_PSQL_CMD")
  if psql_command == nil then
    return "$NVIM_PSQL_CMD is not set"
  end

  local result = vim.fn.systemlist(psql_command, query)

  if result == nil then
    return "Error: No output from query"
  end
  return table.concat(result, "\n")
end

function QuerySelection()
  local query = selected_text()
  local output = execute_query(query)
  show_output(output)
end

-- For faster testing
-- :nmap <leader>w :write<CR>:luafile %<CR>
vim.api.nvim_set_keymap("v", "<leader>e", ":lua QuerySelection()<CR>", { noremap = false, silent = true })
