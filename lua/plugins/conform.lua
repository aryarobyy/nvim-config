return {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                go = { "goimports", "gofumpt" },

                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },

                dart = { "dart_format" },

                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },

                lua = { "stylua" },

                prisma = { "prettier" },
            },

            format_on_save = {
                timeout_ms = 3000,
                lsp_format = "fallback",
            },

            -- formatters = {
            --   prettier = {
            --     prepend_args = {
            --       "--plugin=prettier-plugin-tailwindcss"
            --     },
            --   },
            -- },

            notify_on_error = true,
            notify_no_formatters = true,
        })

        vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', function()
            if vim.bo.buftype ~= "" or not vim.bo.modifiable then
                vim.notify("Cannot save this buffer type", vim.log.levels.WARN)
                return
            end

            vim.cmd('stopinsert')
            
            require("conform").format({
                lsp_format = "fallback",
                timeout_ms = 3000,
            })
            
            vim.cmd('write')
            print('✓ Saved and formatted!')
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
    end,
}

