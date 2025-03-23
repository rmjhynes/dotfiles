return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    -- Generated with figlet
    dashboard.section.header.val = {
      [[                       __                                       ]],
      [[                    __/\ \                                      ]],
      [[ _ __    ___ ___   /\_\ \ \___   __  __    ___      __    ____  ]],
      [[/\`'__\/' __` __`\ \/\ \ \  _ `\/\ \/\ \ /' _ `\  /'__`\ /',__\ ]],
      [[\ \ \/ /\ \/\ \/\ \ \ \ \ \ \ \ \ \ \_\ \/\ \/\ \/\  __//\__, `\]],
      [[ \ \_\ \ \_\ \_\ \_\_\ \ \ \_\ \_\/`____ \ \_\ \_\ \____\/\____/]],
      [[  \/_/  \/_/\/_/\/_/\ \_\ \/_/\/_/`/___/> \/_/\/_/\/____/\/___/ ]],
      [[                   \ \____/          /\___/                     ]],
      [[                    \/___/           \/__/                      ]],
    }

    -- Set menu
    dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
        dashboard.button("l", "  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- Set footer
    local function footer()
        local total_plugins = #vim.tbl_keys(require("lazy").plugins())
        local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
        local version = vim.version()
        local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
        local current_dir = vim.fn.getcwd()

        return datetime .. "   " .. "Current directory: " .. current_dir
    end

    dashboard.section.footer.val = footer()

    -- Set header color
    dashboard.section.header.opts.hl = "AlphaHeader"
    
    -- Set layout
    dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
    }

    -- Set options
    alpha.setup(dashboard.config)

    -- Auto start alpha when no files are specified
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            local should_skip = false
            if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
                should_skip = true
            else
                for _, arg in pairs(vim.v.argv) do
                    if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
                        should_skip = true
                        break
                    end
                end
            end
            if not should_skip then
                alpha.start(true)
            end
        end,
    })
  end,
}
