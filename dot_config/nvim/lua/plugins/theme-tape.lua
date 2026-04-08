local function read_state(name, default)
  local path = vim.fn.expand("~/.tmux/" .. name)
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok or not lines[1] or lines[1] == "" then return default end
  return lines[1]
end

local function write_state(name, value)
  local dir = vim.fn.expand("~/.tmux")
  vim.fn.mkdir(dir, "p")
  vim.fn.writefile({ value }, dir .. "/" .. name)
end

local theme = read_state("theme_name", "zenith")
local mode = read_state("theme_state", "dark")
local theme_root = vim.fn.stdpath("data") .. "/site/pack/theme-tape/start"

local function refresh_state()
  theme = read_state("theme_name", theme)
  mode = read_state("theme_state", mode)
end

local function reload_tmux_theme()
  local tmux_config = vim.fn.expand("~/.tmux/theme-tape.conf")
  if vim.fn.executable("tmux") ~= 1 or vim.fn.filereadable(tmux_config) ~= 1 then return end
  vim.fn.system({ "tmux", "list-sessions" })
  if vim.v.shell_error == 0 then
    vim.fn.system({ "tmux", "source-file", tmux_config })
  end
end

local function current_status_color()
  refresh_state()
  if theme == "cassette-futurism" then
    return mode == "light" and "#d65d0e" or "#ffb86c"
  end
  return "#b070e8"
end

local function apply_theme(next_mode)
  refresh_state()
  if next_mode ~= nil then
    mode = next_mode
  end
  vim.o.background = mode
  write_state("theme_name", theme)
  write_state("theme_state", mode)
  if theme == "cassette-futurism" then
    require("cassette-futurism").setup({ style = mode, transparent = false, dim_inactive = true })
    vim.cmd.colorscheme("cassette-futurism")
  else
    require("zenith").setup({ style = mode, transparent = true, dim_inactive = true })
    vim.cmd.colorscheme("zenith")
  end
  reload_tmux_theme()
end

return {
  {
    dir = theme_root .. "/zenith.nvim",
    name = "zenith",
    lazy = false,
    priority = 1000,
    config = function()
      if read_state("theme_name", "zenith") == "zenith" then apply_theme() end
    end,
  },
  {
    dir = theme_root .. "/cassette-futurism.nvim",
    name = "cassette-futurism",
    lazy = false,
    priority = 1000,
    config = function()
      if read_state("theme_name", "zenith") == "cassette-futurism" then apply_theme() end
    end,
  },
  {
    "AstroNvim/astroui",
    opts = function(_, opts)
      opts.colorscheme = read_state("theme_name", theme)
      opts.status = opts.status or {}
      local prev_colors = opts.status.colors
      opts.status.colors = function(colors)
        if type(prev_colors) == "function" then
          colors = prev_colors(colors) or colors
        end
        colors.normal = current_status_color()
        colors.bg = "NONE"
        colors.section_bg = "NONE"
        return colors
      end
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 3000,
      fallback = "dark",
      set_dark_mode = function()
        apply_theme("dark")
      end,
      set_light_mode = function()
        apply_theme("light")
      end,
    },
  },
}
