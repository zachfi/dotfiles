local M = {}

function M.lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  -- go
  keymap(bufnr, "n", "<leader>gc", "<cmd>GoCoverage -p<CR>", opts)
  keymap(bufnr, "n", "<leader>go", "<cmd>Outline<CR>", opts)
  keymap(bufnr, "n", "<leader>gt", "<cmd>GoTest -n<CR>", opts)
  keymap(bufnr, "n", "<leader>g<space>", "<cmd>GoCodeLenAct<CR>", opts)
  keymap(bufnr, "n", "<leader>ga", "<cmd>GoCodeAction<CR>", opts)
  -- keymap(bufnr, "n", "<leader>gi", "<cmd>GoImplements<CR>", opts)
  keymap(bufnr, "n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", opts)

  -- jsonnet
  keymap(bufnr, "n", "<leader>jv", "<cmd>vertical JsonnetEval<CR>", opts)
end

return M
