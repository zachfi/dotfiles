local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
--keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-n>", ":tabnext<cr>", opts)
keymap("n", "<C-p>", ":tabprev<cr>", opts)
keymap("n", "<C-t>", ":tabnew<cr>", opts)
keymap("n", "<leader>t", 'a<c-r>=strftime("%FT%T%z")<CR><Esc>', opts)
keymap("n", "<S-q>", "gqap", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Reflow the current line
keymap("n", "Q", "gw<CR>", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("n", "<leader>ge", ":GoPkgOutline<CR>", opts)

keymap("n", "<leader>T", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>B", ":TagbarToggle<CR>", opts)

-- ZK
keymap("n", "<leader>zd", ':lua require("zk.commands").get("ZkNew")({ dir = "journal/daily" })<CR>', opts)
keymap("n", "<leader>zw", ':lua require("zk.commands").get("ZkNew")({ dir = "journal/weekly" })<CR>', opts)
keymap("n", "<leader>zt", ":ZkTags<CR>", opts)
keymap("n", "<leader>zo", ":ZkOrphans<CR>", opts)
keymap("n", "<leader>zr", ":ZkRecents<CR>", opts)
keymap("n", "<leader>za", ":ZkNotes<CR>", opts)
keymap("n", "<leader>zn", ":ZkNew<CR>", opts)
keymap("n", "<leader>zi", ":ZkIndex<CR>", opts)
keymap("n", "<leader>zl", ":ZkLinks<CR>", opts)
keymap("n", "<leader>zc", ":ZkCd<CR>", opts)
keymap("n", "<leader>zq", ":lua ToggleTodo()<CR>", opts)
keymap("n", "<leader>zs", ":!make -C ~/notes update<CR>", opts)
