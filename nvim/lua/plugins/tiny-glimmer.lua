return {
  "rachartier/tiny-glimmer.nvim",
  event = "TextYankPost", -- Ensures the plugin loads when TextYankPost is triggered
  config = function()
      require("tiny-glimmer").setup({
          enabled = true,

          -- Disable this if you want to debug highlighting issues
          disable_warnings = true,

          -- Only use if you have a transparent background
          -- It will override the highlight group background color for `to_color` in all animations
          transparency_color = nil,

          overwrite = {
            -- Automatically map keys to overwrite operations
            -- If set to false, you will need to call the API functions to trigger the animations
            -- WARN: You should disable this if you have already mapped these keys
            --        or if you want to use the API functions to trigger the animations
            auto_map = true,

            yank = {
              enabled = true,
              default_animation = "rainbow",
            },

            paste = {
              enabled = true,
              default_animation = "rainbow",

              -- Key to paste
              paste_mapping = "p",

              -- Key to paste above the cursor
              Paste_mapping = "P",
            },
          }
      })
  end,
}
