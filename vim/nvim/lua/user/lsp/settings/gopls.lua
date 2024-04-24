local opts = {
  settings = {
    gopls = {
      -- buildFlags = { "-tags=requires_docker" }, -- custom build flags
      experimentalPostfixCompletions = true,
      analyses = {
        fieldalignment = true,
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      codelenses = {
        gc_details = true,
        upgrade_dependency = true,
        run_govulncheck = true,
        tidy = true,
        vendor = true,
      },

      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },

      gofumpt = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  },
}

return opts
