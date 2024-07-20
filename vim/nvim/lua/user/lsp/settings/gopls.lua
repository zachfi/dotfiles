local opts = {
  settings = {
    gopls = {
      -- buildFlags = { "-tags=requires_docker" }, -- custom build flags
      experimentalPostfixCompletions = true,
      analyses = {
        fieldalignment = true,
        -- nilness = true, -- default on
        shadow = true,
        -- unusedparams = true, -- default on
        unusedvariable = true,
        -- unusedwrite = true, -- default on
        useany = true,
      },
      staticcheck = true,
      semanticTokens = true,
      codelenses = {
        gc_details = true,
        upgrade_dependency = true,
        run_govulncheck = true,
        tidy = true,
        vendor = true,
        test = true,
      },
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = false,
        rangeVariableTypes = false,
      },

      gofumpt = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  },
}

return opts
