local M = {}

M.ui = {
    statusline = {
      enabled = true,
      theme = "default",
      separator_style = "default",
      order = { "mode", "file", "git", "%=", "lsp_msg", "diagnostics", "%=", "lsp", "cwd", "cursor", "percentage"},
      modules = {
          percentage = "%P",
      },
    },
    tabufline = {
        order = { "treeOffset", "buffers", "tabs" },
    }
}

M.base46 = {
    theme = "everforest",
}

M.base_30 = {
  white = "#d8d8d8",
  darker_black = "#000000",
  black = "#000000",
  black2 = "#151515",
  one_bg = "#181818",
  one_bg2 = "#202020",
  one_bg3 = "#303030",
  grey = "#505050",
  grey_fg = "#707070",
  grey_fg2 = "#8a8a8a",
  light_grey = "#b8b8b8",

  red = "#909090",
  baby_pink = "#c0c0c0",
  pink = "#ababab",
  line = "#202020",

  green = "#a0a0a0",
  vibrant_green = "#d8d8d8",
  nord_blue = "#9a9a9a",
  blue = "#9a9a9a",
  yellow = "#b0b0b0",
  sun = "#c6c6c6",
  purple = "#ababab",
  dark_purple = "#707070",
  teal = "#b8b8b8",
  orange = "#aaaaaa",
  cyan = "#b8b8b8",

  statusline_bg = "#151515",
  lightbg = "#202020",
  pmenu_bg = "#303030",
  folder_bg = "#b8b8b8",
}

M.base_16 = {
  base00 = "#000000",
  base01 = "#151515",
  base02 = "#181818",
  base03 = "#303030",
  base04 = "#707070",
  base05 = "#d8d8d8",
  base06 = "#e0e0e0",
  base07 = "#f0f0f0",

  base08 = "#909090",
  base09 = "#aaaaaa",
  base0A = "#c6c6c6",
  base0B = "#a0a0a0",
  base0C = "#b8b8b8",
  base0D = "#9a9a9a",
  base0E = "#ababab",
  base0F = "#707070",
}

M.polish_hl = {
  defaults = {
    Normal = { fg = "#d8d8d8", bg = "#000000" },
    NormalNC = { fg = "#b8b8b8", bg = "#000000" },
    NormalFloat = { fg = "#d8d8d8", bg = "#202020" },
    FloatBorder = { fg = "#707070", bg = "#202020" },

    CursorLine = { bg = "#181818" },
    ColorColumn = { bg = "#181818" },
    LineNr = { fg = "#505050", bg = "#000000" },
    CursorLineNr = { fg = "#d8d8d8", bg = "#181818", bold = true },
    SignColumn = { fg = "#505050", bg = "#000000" },

    Visual = { fg = "#000000", bg = "#c8c8c8" },
    Search = { fg = "#000000", bg = "#b8b8b8" },
    IncSearch = { fg = "#000000", bg = "#e0e0e0", bold = true },
    CurSearch = { fg = "#000000", bg = "#e0e0e0", bold = true },

    Pmenu = { fg = "#d8d8d8", bg = "#202020" },
    PmenuSel = { fg = "#000000", bg = "#c8c8c8", bold = true },
    PmenuThumb = { bg = "#707070" },

    StatusLine = { fg = "#d8d8d8", bg = "#202020" },
    StatusLineNC = { fg = "#707070", bg = "#181818" },

    Comment = { fg = "#707070", italic = true },
    String = { fg = "#415237" },
    Number = { fg = "#aaaaaa" },
    Boolean = { fg = "#c6c6c6", bold = true },
    Function = { fg = "#d8d8d8", bold = true },
    Keyword = { fg = "#99883f", bold = true },
    Statement = { fg = "#c6c6c6", bold = true },
    Type = { fg = "#b8b8b8" },
    Constant = { fg = "#b8b8b8" },
    Identifier = { fg = "#d8d8d8" },
    Operator = { fg = "#b8b8b8" },
    Delimiter = { fg = "#8a8a8a" },
    Special = { fg = "#d8d8d8" },
    Todo = { fg = "#000000", bg = "#d8d8d8", bold = true },
    Error = { fg = "#000000", bg = "#c8c8c8", bold = true },
  },

  treesitter = {
    ["@comment"] = { fg = "#707070", italic = true },
    ["@string"] = { fg = "#415237" },
    ["@string.escape"] = { fg = "#516346" },
    ["@number"] = { fg = "#aaaaaa" },
    ["@number.float"] = { fg = "#aaaaaa" },
    ["@boolean"] = { fg = "#c6c6c6", bold = true },

    ["@function"] = { fg = "#635a46", bold = true },
    ["@function.call"] = { fg = "#635a46" },
    ["@function.builtin"] = { fg = "#635a46" },
    ["@function.method"] = { fg = "#635a46" },
    ["@function.method.call"] = { fg = "#635a46" },

    ["@keyword"] = { fg = "#99883f", bold = true },
    ["@keyword.function"] = { fg = "#99883f", bold = true },
    ["@keyword.return"] = { fg = "#99883f", bold = true },
    ["@keyword.operator"] = { fg = "#99883f", bold = true },
    ["@operator"] = { fg = "#b8b8b8" },

    ["@type"] = { fg = "#b8b8b8" },
    ["@type.builtin"] = { fg = "#b8b8b8", bold = true },

    ["@variable"] = { fg = "#d8d8d8" },
    ["@variable.parameter"] = { fg = "#b8b8b8" },
    ["@variable.builtin"] = { fg = "#c6c6c6" },
    ["@constant"] = { fg = "#b8b8b8" },
    ["@constant.builtin"] = { fg = "#d8d8d8", bold = true },

    ["@property"] = { fg = "#b8b8b8" },
    ["@field"] = { fg = "#b8b8b8" },
    ["@punctuation.delimiter"] = { fg = "#8a8a8a" },
    ["@punctuation.bracket"] = { fg = "#b8b8b8" },

    ["@markup.heading"] = { fg = "#d8d8d8", bold = true },
    ["@markup.link"] = { fg = "#d8d8d8", underline = true },
    ["@markup.link.url"] = { fg = "#d8d8d8", underline = true },

    ["@constant.macro"] = { fg = "#635a46", bold = true },
    ["@function.macro"] = { fg = "#635a46", bold = true },
    ["@keyword.directive"] = { fg = "#8f6a5a", bold = true },
    ["@keyword.directive.define"] = { fg = "#635a46", bold = true },
  },

  nvimtree = {
    NvimTreeNormal = { fg = "#d8d8d8", bg = "#000000" },
    NvimTreeFolderName = { fg = "#b8b8b8" },
    NvimTreeOpenedFolderName = { fg = "#d8d8d8", bold = true },
    NvimTreeRootFolder = { fg = "#d8d8d8", bold = true },
    NvimTreeGitDirty = { fg = "#aaaaaa" },
    NvimTreeGitNew = { fg = "#d8d8d8" },
    NvimTreeGitDeleted = { fg = "#909090" },
  },

  telescope = {
    TelescopeNormal = { fg = "#d8d8d8", bg = "#202020" },
    TelescopeBorder = { fg = "#707070", bg = "#202020" },
    TelescopePromptNormal = { fg = "#d8d8d8", bg = "#181818" },
    TelescopePromptBorder = { fg = "#707070", bg = "#181818" },
    TelescopeSelection = { fg = "#000000", bg = "#c8c8c8", bold = true },
    TelescopeMatching = { fg = "#f0f0f0", bold = true },
  },
}

M.nvdash = {
    load_on_startup = true,
}

M.type = "dark"

return M
