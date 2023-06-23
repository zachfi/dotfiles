local M = {}

M.autoformat = true

function M.on_attach(client, buf)
  -- dont format if client disabled it

  -- default lsp format function
  local f = vim.lsp.buf.format

  if client.name == "gopls" then
    --[[   client.server_capabilities.documentFormattingProvider = false ]]
    local go = require("go.format")

    f = function()
      require("go.format").gofmt()
      require("go.format").goimport()
    end
  end

  if
      client.config
      and client.config.capabilities
      and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
      buffer = buf,
      callback = function()
        if M.autoformat then
          f()
        end
      end,
    })
  end
end

return M
