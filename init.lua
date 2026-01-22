require("config.lazy")
require("lazy").update({ show = false })


vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scl = "yes"
vim.lsp.enable("basedpyright")
vim.g.mapleader = " "


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({ hidden = false })
end, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope man pages' })
vim.keymap.set('n', '<leader><leader>', '<cmd>b#<CR>', { desc = "Mvoe to the previous buffer" })
vim.keymap.set('n', "<leader>bf", vim.lsp.buf.format, { desc = "Format Buffer" })
vim.opt.winborder = 'rounded'

vim.keymap.set("n", "<leader>fb", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>;', ':nohlsearch<CR>', { noremap = true, silent = true })


vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
    callback = function()
        vim.cmd("silent! write")
    end,
})

vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)     -- go to definition
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)    -- go to declaration
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)     -- find references
vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- go to implementation

vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.setloclist, { desc = "Show list of errors" })



vim.keymap.set("n", "<leader>n", function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local Path = require("plenary.path")
    local cwd = vim.loop.cwd()
    local folders = {}

    table.insert(folders, cwd)

    local function scan_dir(dir)
        local handle = vim.loop.fs_scandir(dir)
        if handle then
            while true do
                local name, type = vim.loop.fs_scandir_next(handle)
                if not name then break end
                if type == "directory" then
                    local full_path = Path:new(dir, name):absolute()
                    table.insert(folders, full_path)
                    scan_dir(full_path)
                end
            end
        end
    end

    scan_dir(cwd)

    pickers.new({}, {
        prompt_title = "Select Folder",
        finder = finders.new_table(folders),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local folder = action_state.get_selected_entry()[1]

                vim.ui.input({ prompt = "New file name: " }, function(input)
                    if input and input ~= "" then
                        local file = folder .. "/" .. input
                        vim.cmd("e " .. vim.fn.fnameescape(file))
                    end
                end)
            end)
            return true
        end,
    }):find()
end, { desc = "Create new file in selected folder" })


vim.keymap.set("n", "<leader>d", function()
    local old_path = vim.api.nvim_buf_get_name(0)
    if old_path == "" then
        print("Buffer has no file to delete.")
        return
    end

    local confirm = vim.fn.confirm("Delete file " .. old_path .. "?", "&Yes\n&No", 2)
    if confirm ~= 1 then
        return
    end

    vim.cmd("enew")
    vim.cmd("!rm " .. old_path)
end, { desc = "Delete current file and move to empty buffer." })

vim.keymap.set("n", "<leader>r", function()
    local old_path = vim.api.nvim_buf_get_name(0)
    if old_path == "" then
        print("Buffer has no file to rename.")
        return
    end

    local dir = vim.fn.fnamemodify(old_path, ":h")

    vim.ui.input({ prompt = "New file name (in current folder): " }, function(input)
        if input and input ~= "" and input ~= old_path then
            local new_path = dir .. "/" .. input

            vim.cmd("w")
            vim.cmd("enew")
            vim.cmd("!mv " .. old_path .. " " .. new_path)
            vim.cmd("edit " .. new_path)
            print("File renamed to: " .. new_path)
        else
            print("Rename cancelled.")
        end
    end)
end, { desc = "Rename current file in same folder" })
