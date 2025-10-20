local M = {}

function M.setup()
  vim.pack.add { 'https://github.com/nvim-mini/mini.statusline' }

  local statusline = require 'mini.statusline'

  local active_content = function()
    local function ruler_percentage()
      local current = vim.fn.line '.'
      local total = vim.fn.line '$'
      if total == 0 then
        return '[0%%]'
      end
      local percent = math.floor((current / total) * 100)
      return string.format('[%d%%%%]', percent)
    end

    local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 100 }
    local git = MiniStatusline.section_git { trunc_width = 40 }
    local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
    local filename = MiniStatusline.section_filename { trunc_width = 140 }
    local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
    local location = '%2l:%-2v'
    local search = MiniStatusline.section_searchcount { trunc_width = 75 }
    local ruler = ruler_percentage()

    return MiniStatusline.combine_groups {
      { hl = mode_hl, strings = { mode } },
      { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
      '%<', -- Mark general truncate point
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      { hl = mode_hl, strings = { search, location, ruler } },
    }
  end

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_fileinfo = function(args)
    local filetype = vim.bo.filetype

    -- Construct output string if truncated or buffer is not normal
    if MiniStatusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= '' then
      return filetype
    end

    -- Construct output string with extra file info
    local encoding = vim.bo.fileencoding or vim.bo.encoding
    local format = vim.bo.fileformat

    return string.format('%s%s%s[%s]', filetype, filetype == '' and '' or ' ', encoding, format)
  end

  statusline.setup { use_icons = vim.g.have_nerd_font, content = { active = active_content } }
end

return M
