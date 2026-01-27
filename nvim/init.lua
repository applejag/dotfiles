-- Floating window borders
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

vim.api.nvim_set_keymap('n', '<space>k', '<cmd>lua vim.diagnostic.open_float()<CR>', {
    noremap=true,
    silent=true
})

-- Setup language servers.
vim.lsp.enable('bashls')
vim.lsp.enable('fish_lsp')
vim.lsp.enable('gopls')
vim.lsp.enable('helm_ls')
vim.lsp.enable('jsonls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('nixd')
vim.lsp.enable('terraformls')
vim.lsp.enable('ts_lsp')
vim.lsp.enable('typos_lsp')
vim.lsp.enable('yamlls')
vim.lsp.enable('zizmor')
vim.lsp.enable('zls')
vim.lsp.enable('cue')

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local function optsDesc(desc)
            return { buffer = ev.buf, desc = desc }
        end
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, optsDesc("Go to declaration"))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, optsDesc("Go to definition"))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, optsDesc("Show hover info"))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, optsDesc("Go to implementation"))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, optsDesc("Show signature"))
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, optsDesc("Go to type definition"))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, optsDesc("Rename a symbol"))
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, optsDesc("Select a code action"))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, optsDesc("List all symbol references"))
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, optsDesc("Format current buffer"))
    end,
})

-- hacky way to load a LazyVim plugin without LazyVim
local dankcolors = require 'plugins.dankcolors'
print("dankcolors", dankcolors)
dankcolors[1].config()

-- Snippets plugin, used by cmp
local snippy = require 'snippy'
snippy.setup {
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
    },
}

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require 'cmp'
cmp.setup {
    preselect = cmp.PreselectMode.None,

    snippet = {
        expand = function(args)
            snippy.expand_snippet(args.body)
        end,
    },

    sources = cmp.config.sources({
        -- function signatures: https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
        { name = 'nvim_lsp_signature_help' },
        -- neovim's LSP: https://github.com/hrsh7th/cmp-nvim-lsp/
        { name = 'nvim_lsp' },
        -- snippets expansion: https://github.com/dcampos/cmp-snippy
        { name = 'snippy' },
        -- git commits, PRs, user mentions: https://github.com/petertriho/cmp-git
        { name = 'git' },
        -- paths: https://github.com/hrsh7th/cmp-path/
        { name = 'path' },
    }, {
        -- words in buffer: https://github.com/hrsh7th/cmp-buffer/
        {
            name = 'buffer',
            options = {
                get_bufnrs = function()
                    -- Use all buffers
                    return vim.api.nvim_list_bufs()
                end,
            }
        },
    }),

    mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably '<Tab>'.
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { "i", "s" }),
    },

    window = {
        completion = cmp.config.window.bordered {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Visual,Search:None",
            col_offset = -4,
            side_padding = 0,
        },
        documentation = cmp.config.window.bordered(),
    },

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
        end,
    },
}

require 'cmp_git'.setup {
    filetypes = {
        "gitcommit",
        "octo",
        "markdown",
    },
    github = {
        hosts = { "github.2rioffice.com" },
        pull_requests = {
            state = "all",
        },
    },
    trigger_actions = {
        {
            debug_name = "github_issues_and_pr",
            trigger_character = "#",
            action = function(sources, trigger_char, callback, _, git_info)
                return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
            end,
        },
        {
            debug_name = "github_mentions",
            trigger_character = "@",
            action = function(sources, trigger_char, callback, _, git_info)
                return sources.github:get_mentions(callback, git_info, trigger_char)
            end,
        },
    },
}

-- Customization for nvim-sops
vim.keymap.set('n', '<leader>ef', vim.cmd.SopsEncrypt, { desc = '[E]ncrypt [F]ile' })
vim.keymap.set('n', '<leader>df', vim.cmd.SopsDecrypt, { desc = '[D]ecrypt [F]ile' })

-- Customization for which-key.nvim
vim.o.timeoutlen = 300
require("which-key").setup{}

-- Customization for Pmenu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })

require 'nvim-treesitter.configs'.setup {
    parser_install_dir = "~/.config/nvim",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
        },
    },
}

local file = io.open((os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME").."/.config")).."/nvim/after/queries/yaml/injections.scm", "r")
if file ~= nil then
    vim.treesitter.query.set("yaml", "injections", file:read("a"))
    file:close()
end

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

--[[--
parser_config.templ = {
  install_info = {
    url = "https://github.com/vrischmann/tree-sitter-templ.git",
    files = {"src/parser.c", "src/scanner.c"},
    branch = "master",
  },
}

vim.treesitter.language.register('templ', 'templ')
--]]

vim.filetype.add({
    extension = {
        risor = "risor",
        rsr = "risor",
    },
})

parser_config.risor = {
    install_info = {
        url = "~/code/github.com/jillejr/tree-sitter-risor",
        files = { "src/parser.c" },
    }
}
vim.treesitter.language.register('risor', 'risor')

require 'guess-indent'.setup {}

require 'nvim-surround'.setup {}

require 'ibl'.setup()

-- Special file associations
vim.cmd [[
    autocmd BufRead,BufNewFile */.kube/config set filetype=yaml nowrap
    autocmd BufRead,BufNewFile */.kube/kuberc set filetype=yaml nowrap
    autocmd BufRead,BufNewFile *kubeconfig set filetype=yaml nowrap
    autocmd BufRead,BufNewFile *kubeconfig.yml set filetype=yaml nowrap
    autocmd BufRead,BufNewFile *kubeconfig.yaml set filetype=yaml nowrap
    autocmd BufRead,BufNewFile /tmp/kubeconfigs/* set filetype=yaml nowrap
    autocmd BufRead,BufNewFile .remarkrc set filetype=json
    autocmd BufRead,BufNewFile *.gotmpl set filetype=gotexttmpl
    autocmd BufRead,BufNewFile *.tmpl set filetype=gotexttmpl
    autocmd BufRead,BufNewFile *.yaml.gotmpl set filetype=helm
    autocmd BufRead,BufNewFile *.yml.gotmpl set filetype=helm
    autocmd BufRead,BufNewFile templates/*.yml set filetype=helm
    autocmd BufRead,BufNewFile templates/*.yaml set filetype=helm
    autocmd BufRead,BufNewFile *.yaml.off set filetype=yaml
    autocmd BufRead,BufNewFile *.yml.off set filetype=yaml
    autocmd BufRead,BufNewFile .yamllint set filetype=yaml
    autocmd BufRead,BufNewFile /tmp/kubectl-edit-*.yaml set nowrap
    autocmd BufRead,BufNewFile /dev/shm/gopass-edit*/secret set filetype=yaml nowrap
    autocmd BufRead,BufNewFile */ansible/hosts set filetype=dosini
    autocmd BufRead,BufNewFile */ri-secrets/values-secret.yaml set nowrap
    autocmd BufRead,BufNewFile */ri-clustersecret/values-secret.yaml set nowrap
    autocmd BufRead,BufNewFile JenkinsFile set filetype=Jenkinsfile
    autocmd BufRead,BufNewFile */templates/NOTES.txt set filetype=gotexttmpl
    autocmd BufRead,BufNewFile PROJECT set filetype=yaml
    autocmd BufRead,BufNewFile *.j2 set filetype=jinja
]]

-- YAML indent fix
vim.cmd [[
    augroup filetype_yaml
        autocmd!
        autocmd BufEnter *.yaml,*.yml
            \ setlocal indentkeys-=0#
    augroup END
]]

-- Options

--vim.cmd [[colorscheme dracula]]

vim.g.mapleader = " "
vim.opt.winborder = "rounded"
vim.opt.wrap = false -- disable word wrapping
vim.opt.termguicolors = true
vim.opt.encoding = "UTF-8"
vim.opt.listchars = {
    space = "⋅",
}
vim.opt.mouse = "nvi"      -- mouse support in normal, visual, and insert modes
vim.opt.signcolumn = "yes" -- always show line alert column

vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 4 -- tab visual size
vim.opt.shiftwidth = 4

vim.opt.number = true             -- show line numbers
--vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus" -- use system clipboard

vim.opt.showtabline = 2           -- 2=always
vim.opt.cursorline = true         -- highlight current line
vim.opt.colorcolumn = { 80 }

vim.opt.updatetime = 500
