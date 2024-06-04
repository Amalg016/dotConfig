-- java setup
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local home = os.getenv 'HOME'
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        -- '-Dosgi.requiredJavaVersion=11',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.level=ALL',
        '-noverify',
        '-Xmx4G',
        '--add-modules=ALL-SYSTEM',
        --'--add-modules=java.base,java.logging,java.sql,java.xml,java.desktop,java.management,java.naming,java.rmi,java.scripting,java.security.jgss,java.security.sasl,java.sql.rowset,java.transaction.xa,java.xml.bind,java.xml.crypto,jdk.httpserver,jdk.unsupported,jdk.zipfs',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', home ..
    '/.cache/nvim/nvim_lsp/jdtls/plugins/org.eclipse.equinox.launcher_1.5.700.v20200207-2156.jar',
        '-configuration', home .. '/.cache/nvim/nvim_lsp/jdtls/config_mac',
        '-data', vim.fn.expand('~/.cache/jdtls-workspace-') .. workspace_dir,
        -- See `data directory configuration` section in the README
    },
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'mvnw', 'gradlew' }, { upward = true })[1]),
    capabilities = lsp_capabilities,
    init_options = {
        bundles = {
            vim.fn.glob(
                '/Users/amal-18877/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar')
            --TODO Install java-debug and java-test from Mason DAP ---------> if the above code doesnt work, go to the above directory and find the actual version and paste it here!
        }
    }
}

config['on_attach'] = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

--TODO Download the jdtls from https://download.eclipse.org/jdtls/milestones/       -0.57 version
require('jdtls').start_or_attach(config)

function attach_to_debug()
    local dap = require('dap')
    -- print(dap)
    dap.configurations.java = {
        {
            type = 'java',
            request = 'attach',
            name = "Attach to Java Process",
            hostName = "localhost",
            port = 8000
        }
    }
    dap.continue()
    print("attached")
end

function run_app(debug)
    if debug then
        vim.cmd('term' .. './gradlew startTomcat -Pdebug=true')
    else
        vim.cmd('term' .. './gradlew startTomcat')
    end
end

-- Attach debug Session
vim.keymap.set("n", "<Leader>ll", ':lua attach_to_debug()<CR>')

-- Debug
vim.keymap.set("n", "<F10>", ':lua run_app(true)<CR>')

-- Run
vim.keymap.set("n", "<F9>", ':lua run_app()<CR>')
