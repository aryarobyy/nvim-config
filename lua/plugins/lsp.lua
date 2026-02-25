return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local autoformat_filetypes = {
            "lua",
        }
        
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end
                if vim.tbl_contains(autoformat_filetypes, vim.bo.filetype) then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({
                                formatting_options = { tabSize = 4, insertSpaces = true },
                                bufnr = args.buf,
                                id = client.id
                            })
                        end
                    })
                end
            end
        })

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { 
                border = 'rounded',
                max_width = 80,  -- Lebar maksimal 
                max_height = 30, -- Tinggi maksimal
            }
        )
        
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { 
                border = 'rounded',
                max_width = 80,
                max_height = 30,
            }
        )

        vim.diagnostic.config({
            virtual_text = true,
            severity_sort = true,
            float = {
                style = 'minimal',
                border = 'rounded',
                header = '',
                prefix = '',
                max_width = 80, 
                max_height = 30,
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '▲',
                    [vim.diagnostic.severity.HINT] = '⚑',
                    [vim.diagnostic.severity.INFO] = '»',
                },
            },
        })
        local lspconfig_defaults = require('lspconfig').util.default_config
        local capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.preselectSupport = true
        capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
        capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
        capabilities.textDocument.completion.completionItem.deprecatedSupport = true
        capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
        capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = { 'documentation', 'detail', 'additionalTextEdits' }
        }

        lspconfig_defaults.capabilities = capabilities



        require('mason').setup({})

        local mason_packages = vim.fn.stdpath('data') .. '/mason/packages'
        local vue_plugin_path = mason_packages .. '/vue-language-server/node_modules/@vue/language-server'

        vim.lsp.config('*', {
            capabilities = capabilities,
        })

        vim.lsp.config('vtsls', {
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = {
                            {
                                name = "@vue/typescript-plugin",
                                location = vue_plugin_path,
                                languages = { "vue" },
                                configNamespace = "typescript",
                                enableForWorkspaceTypeScriptVersions = true,
                            },
                        },
                    },
                },
            },
        })

        vim.lsp.config('vue_ls', {
            init_options = {
                typescript = {
                    tsdk = mason_packages .. '/vtsls/node_modules/.package/node_modules/typescript/lib',
                },
            },
        })

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = {
                            vim.env.VIMRUNTIME,
                            vim.fn.stdpath('config'),
                        },
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                    hint = {
                        enable = true,
                        setType = true,
                    },
                    completion = {
                        callSnippet = "Replace",
                        keywordSnippet = "Replace",
                        displayContext = 10,
                        showWord = "Disable",
                    },
                    hover = {
                        expandAlias = true,
                    },
                },
            },
        })

        vim.lsp.config('tailwindcss', {
            filetypes = {
                'aspnetcorerazor',
                'astro',
                'astro-markdown',
                'blade',
                'clojure',
                'django-html',
                'edde',
                'edge',
                'eelixir',
                'ejs',
                'erb',
                'eruby',
                'gohtml',
                'haml',
                'handlebars',
                'hbs',
                'html',
                'html-eex',
                'heex',
                'jade',
                'leaf',
                'liquid',
                'markdown',
                'mdx',
                'mustache',
                'njk',
                'nunjucks',
                'php',
                'pug',
                'razor',
                'slim',
                'statamic',
                'svelte',
                'twig',
                'typescriptreact',
                'javascriptreact',
                'vue',
                'templ',
            },
            init_options = {
                userLanguages = {
                    ['templ'] = 'html',
                },
            },
        })

        vim.lsp.config('eslint', {
            settings = {
                workingDirectory = { mode = 'auto' },
                rulesCustomizations = {
                    { rule = 'import/no-unresolved', severity = 'off' },
                },
            },
        })

        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",
                "intelephense",
                "vtsls",
                "eslint",
                "vue_ls",
                "gopls",
                -- "dartls",
                "pyright",
                "prismals",
                "tailwindcss",
            },
        })

        local cmp = require('cmp')
        require('luasnip.loaders.from_vscode').lazy_load({ exclude = { "python" } })

        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

        cmp.setup({
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            window = {
                documentation = {
                    border = 'rounded',
                    max_height = 20,  -- Tinggi window dokumentasi
                    max_width = 80,   -- Lebar window dokumentasi
                },
                completion = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
                { name = 'path' },
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            formatting = {
                fields = { 'abbr', 'menu', 'kind' },
                format = function(entry, item)
                    local n = entry.source.name
                    if n == 'nvim_lsp' then
                        item.menu = '[LSP]'
                    else
                        item.menu = string.format('[%s]', n)
                    end
                    return item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-f>'] = cmp.mapping.scroll_docs(5),
                ['<C-u>'] = cmp.mapping.scroll_docs(-5),
                ['<C-e>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    local col = vim.fn.col('.') - 1
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = 'select' })
                    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                ['<C-d>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-b>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
        })
    end
}