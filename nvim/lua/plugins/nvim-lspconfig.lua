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
                'gradle_ls',
                'lua_ls',
                -- 'intelephense', -- requires npm to be installed
                -- 'jsonls', -- requires npm to be installed
                --'lemminx',
                'marksman',
                'tsserver',
                -- 'prettier',
                'eslint'
                --  'rust_analyzer'
                -- 'tsserver', -- requires npm to be installed
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



        -- js, ts
        lspconfig.tsserver.setup {}

        -- marksman
        lspconfig.marksman.setup {}

        -- java setup
        --local jdtls_ok, jdtls = pcall(require, "jdtls")
        --if not jdtls_ok then
        --    vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
        --    return
        --end
        -- local home = os.getenv 'HOME'
        -- local jdtls_path = vim.fn.stdpath('data') .. "/lsp_servers/jdtls"
        -- local path_to_lsp_server = jdtls_path .. "/config_mac"
        --local config = {
        --    -- The command that starts the language server
        --    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        --    cmd = {
        --        '-java',
        --        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        --        '-Dosgi.bundles.defaultStartLevel=4',
        --        '-Dosgi.requiredJavaVersion=11',
        --        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        --        '-Dlog.protocol=true',
        --        '-Dlog.level=ALL',
        --        '-Xmx1g',
        --        '--add-modules=ALL-SYSTEM',
        --        --'--add-modules=java.base,java.logging,java.sql,java.xml,java.desktop,java.management,java.naming,java.rmi,java.scripting,java.security.jgss,java.security.sasl,java.sql.rowset,java.transaction.xa,java.xml.bind,java.xml.crypto,jdk.httpserver,jdk.unsupported,jdk.zipfs',
        --        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        --        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        --        '-jar',
        --        '/Users/amal-18877/state/nvim/lsp/jdt-language-server-0.57.0-202006172108/plugins/org.eclipse.equinox.launcher_*.jar',
        --        '-configuration', '/Users/amal-18877/state/nvim/lsp/jdt-language-server-0.57.0-202006172108/config_mac/'
        --        -- See `data directory configuration` section in the README
        --    },

        --    -- This is the default if not provided, you can remove it. Or adjust as needed.
        --    -- One dedicated LSP server & client will be started per unique root_dir

        --    root_dir = lspconfig.util.root_pattern("build.gradle", ".git", "settings.gradle", "gradlew"),
        --}

        --nvimjdtls.setup(config)

        --java
        -- lspconfig.gradle_ls.setup {
        --     cmd = { "gradle-language-server" },
        --     filetypes = { "gradle", "java" },
        --     root_dir = lspconfig.util.root_pattern("build.gradle", ".git", "settings.gradle", "gradlew"),
        -- }
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
