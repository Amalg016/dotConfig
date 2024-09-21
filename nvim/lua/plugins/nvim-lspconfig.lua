-- LSP Support
return {
    -- LSP Configuration
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        -- LSP Management
        -- https://github.com/williamboman/mason.nvim
        { 'williamboman/mason.nvim' },
        -- https://github.com/williamboman/mason-lspconfig.nvim
        { 'williamboman/mason-lspconfig.nvim' },
        -- Useful status updates for LSP
        -- https://github.com/j-hui/fidget.nvim
        { 'j-hui/fidget.nvim',                opts = {} },
        { 'mfussenegger/nvim-jdtls' },
        -- Additional lua configuration, makes nvim stuff amazing!
        -- https://github.com/folke/neodev.nvim
        { 'folke/neodev.nvim' },
    },
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup({
            -- Install these LSPs automatically
            ensure_installed = {
                'bashls', -- requires npm to be installed
                -- 'cssls', -- requires npm to be installed
                -- 'html', -- requires npm to be installed
                -- 'gradle_ls',
                'lua_ls',
                -- 'intelephense', -- requires npm to be installed
                -- 'jsonls', -- requires npm to be installed
                --'lemminx',
                -- 'marksman',
                -- 'prettier',
                -- 'eslint'
                --  'rust_analyzer'
                'tsserver', -- requires npm to be installed
                -- 'yamlls', -- requires npm to be installed
            }
        })

        local lspconfig = require('lspconfig')
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lsp_attach = function(client, bufnr)
            -- Create your keybindings here...
        end

        -- Call setup on eacah LSP server
        require('mason-lspconfig').setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    on_attach = lsp_attach,
                    capabilities = lsp_capabilities,
                    handlers = {
                        -- Add borders to LSP popups
                        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
                        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
                            { border = 'rounded' }),
                    }
                })
            end
        })
        local util = require "lspconfig/util"
        -- Golang server
        lspconfig.gopls.setup {
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            -- root_dir = vim.fs.dirname(vim.fs.find({ "go.work", "go.mod", "git" })),
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    },
                },
            },
        }

        -- js, ts
        lspconfig.tsserver.setup {}
        -- lspconfig.eslint.setup {}

        -- marksman
        lspconfig.marksman.setup {}

        -- java handled in java.lua file

        -- Lua LSP settings
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                },
            },
        }
    end
}

-- root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'mvnw', 'gradlew' }, { upward = true })[1]),
--'/Users/amal-18877/.local/share/nvim/mason/packages/openjdk-17/jdk-17.0.2.jdk/Contents/Home/bin/'
