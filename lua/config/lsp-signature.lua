return {
    'ray-x/lsp_signature.nvim',
    event = "VeryLazy",
    opts = {
        bind = true,
        handler_opts = {
            border = "rounded"
        },
        hint_enable = true,
        hint_prefix = "🐼 ",
        hi_parameter = "LspSignatureActiveParameter",
        max_height = 22,
        max_width = 120,
        floating_window = true,
        floating_window_above_cur_line = true,
        doc_lines = 20,
        toggle_key = '<C-k>',
    },
    config = function(_, opts)
        require('lsp_signature').setup(opts)
    end
}
