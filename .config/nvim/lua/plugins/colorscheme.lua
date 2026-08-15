return {
  -- theme
  { "vague-theme/vague.nvim" },

  -- dynamic colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        local result = handle and handle:read("*a") or ""
        if handle then
          handle:close()
        end

        if result:match("Dark") then
          return "vague" -- dark variant
        else
          return "vague-light" -- if the theme supports it
        end
      end,
    },
  },
}
