local M = {}

M.autoformat = true

function M.on_attach(client, buf)
  -- dont format if client disabled it

  if client.name == "gopls" then
    client.server_capabilities.documentFormattingProvider = false
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
          vim.lsp.buf.format()
        end
      end,
    })
  end
end

return M
