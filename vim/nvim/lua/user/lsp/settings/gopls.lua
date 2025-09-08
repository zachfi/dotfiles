local opts = {
  settings = {
    gopls = {
      -- buildFlags = { "-tags=requires_docker" }, -- custom build flags
      experimentalPostfixCompletions = true,
      analyses = {
        -- nilness = true, -- default on
        shadow = true,
        -- unusedparams = true, -- default on
        unusedvariable = true,
        -- unusedwrite = true, -- default on
        useany = true,
        SA1029 = true,    -- Inappropriate key in call to context.WithValue
        SA1030 = true,    -- Invalid argument in call to a strconv function
        SA1031 = true,    -- Overlapping byte slices passed to an encoder
        SA1032 = true,    -- Wrong order of arguments to errors.Is
        SA2001 = true,    -- Empty critical section, did you mean to defer the unlock?
        SA4009 = true,    -- A function argument is overwritten before its first use
        SA4010 = true,    -- The result of append will never be observed anywhere
        SA4012 = true,    -- Comparing a value against NaN even though no value is equal to NaN
        SA4015 = true,    -- Calling functions like math.Ceil on floats converted from integers doesn't do anything useful
        SA4017 = true,    -- Discarding the return values of a function without side effects, making the call pointless
        SA4018 = true,    -- Self-assignment of variables
        SA4031 = true,    -- Checking never-nil value against nil
        SA5000 = true,    -- Assignment to nil map
        SA5005 = true,    -- The finalizer references the finalized object, preventing garbage collection
        SA6001 = true,    -- Missing an optimization opportunity when indexing maps by byte slices
        SA6002 = true,    -- Storing non-pointer values in sync.Pool allocates memory
        SA9001 = true,    -- Defers in range loops may not run when you expect them to
        SA9002 = true,    -- Using a non-octal os.FileMode that looks like it was meant to be in octal
        SA9005 = true,    -- Trying to marshal a struct with no public fields nor custom marshaling
        ST1003 = true,    -- Poorly chosen identifier
        ST1005 = true,    -- Incorrectly cased error string
        ST1006 = true,    -- Receiver name should be consistent with the type name
        ST1008 = true,    -- A function's error value should be its last return value
        ST1011 = true,    -- Poorly chosen name for variable of type time.Duration
        ST1012 = true,    -- Poorly chosen name for error variable
        ST1013 = true,    -- Should use constants for HTTP error codes, not magic numbers
        ST1016 = true,    -- Use consistent method receiver names
        ST1017 = true,    -- Don't use Yoda conditions
        ST1018 = true,    -- Avoid zero-width and control characters in string literals
        ST1019 = true,    -- Importing the same package multiple times
        ST1020 = true,    -- The documentation of an exported function should start with the function's name
        ST1021 = true,    -- The documentation of an exported type should start with the type's name
        appendclipped = true, -- simplify append chains using slices.Concat
        slicesdelete = true, -- replace append-based slice deletion with slices.Delete
      },
      staticcheck = true,
      vulncheck = "Imports",
      semanticTokens = true,
      templateExtensions = { "tmpl", "gotmpl" },
      hoverKind = "SynopsisDocumentation",
      codelenses = {
        gc_details = true,
        upgrade_dependency = true,
        tidy = true,
        vendor = true,
        test = true,
        vulncheck = true,
        generate = true,
      },
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = false,
        ignoredError = true,
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
