return {
  {
    "bjarneo/aether.nvim",
    name = "aether",
    priority = 1000,
    opts = {
      disable_italics = false,
      colors = {
        -- Monotone shades (base00-base07)
        base00 = "#1b1d1e", -- Default background
        base01 = "#505354", -- Lighter background (status bars)
        base02 = "#fcef0c", -- Selection background
        base03 = "#62605f", -- Comments, invisibles
        base04 = "#c6c5bf", -- Dark foreground
        base05 = "#dadbd6", -- Default foreground
        base06 = "#dadbd6", -- Light foreground
        base07 = "#c6c5bf", -- Light background

        -- Accent colors (base08-base0F)
        base08 = "#e6dc44", -- Variables, errors, red
        base09 = "#fff78e", -- Integers, constants, orange
        base0A = "#f4fd22", -- Classes, types, yellow
        base0B = "#c8be46", -- Strings, green
        base0C = "#62605f", -- Support, regex, cyan
        base0D = "#737174", -- Functions, keywords, blue
        base0E = "#747271", -- Keywords, storage, magenta
        base0F = "#feed6c", -- Deprecated, brown/yellow
      },
    },
    config = function(_, opts)
      require("aether").setup(opts)
      vim.cmd.colorscheme("aether")

      -- Align selection colors with other themes; reapply on colorscheme changes
      local function set_kostox_highlights()
        local bg = "#1b1d1e"
        local panel = "#232627"
        local panel_alt = "#2f3334"
        local fg = "#dadbd6"
        local muted = "#a3a3a6"
        local dim = "#62605f"
        local yellow = "#f4fd22"
        local soft_yellow = "#feed6c"
        local black = "#000000"

        vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "NormalFloat", { fg = fg, bg = panel })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = yellow, bg = panel })
        vim.api.nvim_set_hl(0, "Pmenu", { fg = fg, bg = panel })
        vim.api.nvim_set_hl(0, "PmenuSel", { fg = black, bg = yellow, bold = true })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = panel })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = yellow, bold = true })
        vim.api.nvim_set_hl(0, "LineNr", { fg = dim })
        vim.api.nvim_set_hl(0, "Visual", { bg = yellow, fg = black })
        vim.api.nvim_set_hl(0, "VisualNOS", { bg = yellow, fg = black })
        vim.api.nvim_set_hl(0, "Search", { bg = soft_yellow, fg = black })
        vim.api.nvim_set_hl(0, "IncSearch", { bg = yellow, fg = black, bold = true })
        vim.api.nvim_set_hl(0, "MatchParen", { bg = panel_alt, fg = yellow, bold = true })
        vim.api.nvim_set_hl(0, "StatusLine", { fg = black, bg = yellow, bold = true })
        vim.api.nvim_set_hl(0, "StatusLineNC", { fg = muted, bg = panel })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = dim })
        vim.api.nvim_set_hl(0, "Comment", { fg = muted, italic = true })
        vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#e6dc44" })
        vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = soft_yellow })
        vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = muted })
        vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = yellow })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = yellow, bg = panel })
        vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = fg, bg = panel })
        vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = black, bg = yellow, bold = true })
      end
      set_kostox_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "aether",
        callback = set_kostox_highlights,
      })

      -- Enable hot reload
      require("aether.hotreload").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
