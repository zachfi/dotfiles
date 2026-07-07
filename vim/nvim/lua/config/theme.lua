-- Light/dark theme switching.
--
-- Today: <leader>xc toggles between a dark and a light colorscheme (keymap in
-- plugins/which-key.lua). The pair is defined here so changing it is one line.
-- The dark theme here is also the one applied at startup (see the material.nvim
-- config in plugins/colorscheme.lua, which calls M.dark()).
--
-- ── Direction / breadcrumb for future work (and other machines) ──────────────
-- Goal: have Neovim FOLLOW the system light/dark mode set by DankMaterialShell
-- (DMS) instead of toggling by hand. Sketched approach, not yet built:
--   1. DMS is the source of truth for the mode. Ideally it sets the freedesktop
--      `org.freedesktop.appearance color-scheme` portal preference — a
--      system-wide contract every app (GTK/Qt/terminal/nvim) can follow —
--      or, failing that, writes a small state file (e.g. ~/.cache/dank/mode).
--   2. Neovim follows via f-person/auto-dark-mode.nvim: give it a detection
--      command that reads that portal/file, and point its set_dark_mode /
--      set_light_mode callbacks at M.dark() / M.light() below. It polls, so
--      there's no socket/signal plumbing into running nvim instances.
-- This is a cross-app change (it touches the DMS/shell config and affects other
-- apps too), so it deserves its own scoping pass before implementation. The
-- M.dark()/M.light() split below is intentionally the seam that work plugs into.
-- ────────────────────────────────────────────────────────────────────────────

local M = {}

-- The dark/light pair. Both names are registered by material.nvim
-- (marko-cerovac/material.nvim). Swap for any dual-mode themes you prefer, e.g.
-- tokyonight-night/tokyonight-day or catppuccin-mocha/catppuccin-latte — all are
-- already installed (see plugins/colorscheme.lua).
M.dark_theme = "material-palenight"
M.light_theme = "material-lighter"

function M.dark()
  vim.o.background = "dark"
  vim.cmd.colorscheme(M.dark_theme)
end

function M.light()
  vim.o.background = "light"
  vim.cmd.colorscheme(M.light_theme)
end

function M.toggle()
  if vim.o.background == "dark" then
    M.light()
  else
    M.dark()
  end
end

return M
