-- Basic settings
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.mouse = "a"
vim.opt.autoread = true

-- Disable GUI options
vim.opt.guioptions:remove("m")
vim.opt.guioptions:remove("M") 
vim.opt.guioptions:remove("T")
vim.opt.guioptions:remove("e")

-- Whitespace settings
vim.opt.backspace = {"indent", "eol", "start"}
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.textwidth = 80
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.formatoptions = "qrn1"
vim.opt.listchars = {tab = "▸ ", eol = "¬", extends = "»", precedes = "«", trail = "•"}
vim.opt.cindent = true

-- Additional settings
vim.opt.signcolumn = "yes:1"
vim.opt.background = "light"
vim.opt.splitkeep = "screen"
vim.opt.mousescroll = "ver:5,hor:2"

-- Global variables
vim.g.EasyClipShareYanks = 1
vim.g.EasyClipEnableBlackHoleRedirect = 0
vim.g.pymode_indent = 0
vim.g.SuperTabDefaultCompletionType = "context"
vim.g.fzf_preview_window = {}
vim.g.go_def_mode = "gopls"
vim.g.go_info_mode = "gopls"
vim.g.tmux_navigator_preserve_zoom = 1
vim.g.tmux_navigator_no_mappings = 1
vim.g.NERDTreeNodeDelimiter = "\u{00A0}"

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  -- Color schemes
  { "shaunsingh/solarized.nvim" },
  { "sjl/badwolf" },
  { "RRethy/nvim-base16" },
  { "jeffkreeftmeijer/vim-dim" },

  -- File management and navigation
  {
    "scrooloose/nerdtree",
    keys = {
      { "<C-u>", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
      { "<D-u>", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
    },
  },

  -- Text manipulation
  { "junegunn/vim-easy-align" },
  { "tpope/vim-repeat" },
  { "tpope/vim-rhubarb" },
  { "svermeulen/vim-easyclip" },
  { "Vimjas/vim-python-pep8-indent" },
  { "tomtom/tcomment_vim" },
  { "tpope/vim-surround" },
  { "tpope/vim-fugitive" },
  { "ervandew/supertab" },
  { "drzel/vim-split-line" },

  -- Language support
  {
    "fatih/vim-go",
    build = ":GoUpdateBinaries",
    ft = "go",
  },
  { "google/vim-jsonnet", ft = "jsonnet" },

  -- AI assistance
  { "github/copilot.vim" },

  -- Lisp support
  { "guns/vim-sexp" },
  { "tpope/vim-sexp-mappings-for-regular-people" },

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Tmux integration
  { "christoomey/vim-tmux-navigator" },

  -- Visual enhancements
  { "RRethy/vim-illuminate" },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<C-j>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 1,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
        winbar = { enabled = false }
      })
      
      -- VimR specific mapping
      if vim.fn.has("gui_vimr") == 1 then
        require("toggleterm").setup({
          open_mapping = [[<D-j>]],
        })
      end
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_install = { "hcl", "terraform" },
        highlight = {
          enable = true
        }
      })
    end,
  },

  -- Completion
  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    dependencies = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
  },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "tami5/lspsaga.nvim" },

  -- FZF
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  { "junegunn/fzf.vim" },
})

-- Key mappings
local keymap = vim.keymap.set

-- General mappings
keymap("n", ";", ":")
keymap("n", "<C-p>", ":FZF<cr>")
keymap("n", "<leader>f", ":FZF<cr>")
keymap("n", "<tab>", ":Buffers<CR>")
keymap("i", "jj", "<Esc>")

-- Tmux navigator mappings
keymap("n", "<Esc>H", ":<C-U>TmuxNavigateLeft<cr>", { silent = true })
keymap("n", "<Esc>J", ":<C-U>TmuxNavigateDown<cr>", { silent = true })
keymap("n", "<Esc>K", ":<C-U>TmuxNavigateUp<cr>", { silent = true })
keymap("n", "<Esc>L", ":<C-U>TmuxNavigateRight<cr>", { silent = true })

keymap("n", "<D-H>", ":<C-U>TmuxNavigateLeft<cr>", { silent = true })
keymap("n", "<D-J>", ":<C-U>TmuxNavigateDown<cr>", { silent = true })
keymap("n", "<D-K>", ":<C-U>TmuxNavigateUp<cr>", { silent = true })
keymap("n", "<D-L>", ":<C-U>TmuxNavigateRight<cr>", { silent = true })

keymap("n", "<D-r>", ":<C-U>vs<cr>", { silent = true })
keymap("n", "<D-s>", ":<C-U>sp<cr>", { silent = true })

-- LSP saga mapping
keymap("n", "gh", ":Lspsaga lsp_finder<CR>", { silent = true })

-- Folding mappings
keymap("n", "<Space>", "@=(foldlevel('.')?'za':\"\\<Space>\")<CR>", { silent = true, expr = true })
keymap("v", "<Space>", "zf")

-- LSP configuration using new vim.lsp.config API
local function setup_lsp_keymaps(bufnr)
  local function buf_keymap(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  local opts = { noremap = true, silent = true }

  -- LSP key mappings
  buf_keymap("n", "gD", vim.lsp.buf.declaration, opts)
  buf_keymap("n", "gd", vim.lsp.buf.definition, opts)
  buf_keymap("n", "K", vim.lsp.buf.hover, opts)
  buf_keymap("n", "gi", vim.lsp.buf.implementation, opts)
  buf_keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  buf_keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  buf_keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  buf_keymap("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  buf_keymap("n", "<space>D", vim.lsp.buf.type_definition, opts)
  buf_keymap("n", "<space>rn", vim.lsp.buf.rename, opts)
  buf_keymap("n", "<space>ca", vim.lsp.buf.code_action, opts)
  buf_keymap("n", "gr", vim.lsp.buf.references, opts)
  buf_keymap("n", "<space>e", vim.diagnostic.open_float, opts)
  buf_keymap("n", "[d", vim.diagnostic.goto_prev, opts)
  buf_keymap("n", "]d", vim.diagnostic.goto_next, opts)
  buf_keymap("n", "<space>q", vim.diagnostic.setloclist, opts)
  buf_keymap("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

-- Setup LSP attach autocmd
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    
    -- Setup keymaps
    setup_lsp_keymaps(bufnr)
  end,
})

-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Enable inlay hints globally
vim.lsp.inlay_hint.enable(true)

-- Setup language servers using new API
local servers = {
  pylsp = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        procMacro = {
          enable = true,
        },
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
        inlayHints = {
          enable = true,
          chainingHints = true,
          parameterHints = true,
          typeHints = true,
        },
      }
    }
  },
  ts_ls = {},
  gopls = {},
  terraformls = {
    settings = {
      terraform = {
        validate = {
          enable = true,
          enableEnhancedValidation = true
        }
      }
    }
  },
  diagnosticls = {
    filetypes = { 
      "javascript", "javascriptreact", "json", "typescript", 
      "typescriptreact", "css", "less", "scss", "markdown", "pandoc" 
    },
    init_options = {
      linters = {
        eslint = {
          command = "eslint_d",
          rootPatterns = { ".git" },
          debounce = 100,
          args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
          sourceName = "eslint_d",
          parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "[eslint] ${message} [${ruleId}]",
            security = "severity"
          },
          securities = {
            [2] = "error",
            [1] = "warning"
          }
        },
      },
      filetypes = {
        javascript = "eslint",
        javascriptreact = "eslint",
        typescript = "eslint",
        typescriptreact = "eslint",
      },
      formatters = {
        eslint_d = {
          command = "eslint_d",
          args = { "--stdin", "--stdin-filename", "%filename", "--fix-to-stdout" },
          rootPatterns = { ".git" },
        },
        prettier = {
          command = "prettier",
          args = { "--stdin-filepath", "%filename" }
        }
      },
      formatFiletypes = {
        css = "prettier",
        javascript = "eslint_d",
        javascriptreact = "eslint_d",
        json = "prettier",
        scss = "prettier",
        less = "prettier",
        typescript = "eslint_d",
        typescriptreact = "eslint_d",
        markdown = "prettier",
      }
    }
  }
}

-- Enable LSP servers
for server_name, config in pairs(servers) do
  vim.lsp.enable(server_name, config)
end

-- Terraform autocommands
vim.api.nvim_create_augroup("terraform", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "terraform",
  pattern = "terraform",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- True color support
if vim.fn.exists("+termguicolors") == 1 then
  vim.env.t_8f = "\27[38;2;%lu;%lu;%lum"
  vim.env.t_8b = "\27[48;2;%lu;%lu;%lum"
  vim.opt.termguicolors = true
end

-- VimR specific settings
if vim.fn.has("gui_vimr") == 1 then
  vim.cmd("colorscheme base16-gruvbox-light-soft")
end

-- Disable syntax and line numbers (as in original)
vim.cmd("syntax off")
vim.opt.number = false

-- Enable autoread: automatically reload file if it changes on disk
vim.o.autoread = true

-- Autocommand to check for file changes when focus is gained or buffer is entered
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime"
})

-- Optional: Notify if file was reloaded due to external change
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.api.nvim_echo(
      {{"File changed on disk. Buffer reloaded.", "WarningMsg"}},
      false,
      {}
    )
  end
})

-- Optional: Warn if the file has changed and you're trying to write it (conflict detection)
vim.api.nvim_create_autocmd("FileChangedShell", {
  callback = function()
    vim.api.nvim_echo(
      {{"Warning: File changed outside of Neovim.", "ErrorMsg"}},
      false,
      {}
    )
  end
})

-- set keybinding to toggle copilot
keymap("n", "<leader>c", ":Copilot toggle<CR>")