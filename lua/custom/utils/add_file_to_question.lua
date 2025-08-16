-- lua/utils/addfiletoquestion.lua

local M = {}

local question_file = "ignored/question.txt"

local function ensure_dir_exists(filepath)
  local dir = vim.fn.fnamemodify(filepath, ":h")
  if dir ~= "" then
    vim.fn.mkdir(dir, "p")
  end
end

local function read_file(path)
  local f, err = io.open(path, "r")
  if not f then
    return nil, err or ("failed to open " .. path)
  end
  local content = f:read("*a")
  f:close()
  return content
end

local function append_block_to_question(filepath)
  local rel = vim.fn.fnamemodify(filepath, ":.")
  ensure_dir_exists(question_file)

  local content, rerr = read_file(filepath)
  if not content then
    vim.notify("Could not read file: " .. rerr, vim.log.levels.ERROR)
    return
  end

  local ok, ferr = pcall(function()
    local f = assert(io.open(question_file, "a"))
    f:write("\n")
    f:write("<" .. rel .. ">\n")
    f:write(content)
    if not content:match("\n$") then
      f:write("\n")
    end
    f:write("</" .. rel .. ">\n\n")
    f:close()
  end)

  if not ok then
    vim.notify("Failed to append to " .. question_file .. ": " .. tostring(ferr), vim.log.levels.ERROR)
  else
    vim.notify("Added " .. rel .. " → " .. question_file, vim.log.levels.INFO)
  end
end

function M.pick_file_and_append()
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  builtin.find_files({
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if not entry then
          vim.notify("No file selected", vim.log.levels.WARN)
          return
        end

        local fp = entry.path or entry.filename or entry.value
        if not fp or fp == "" then
          vim.notify("Could not determine file path from selection", vim.log.levels.ERROR)
          return
        end

        append_block_to_question(fp)
      end)
      return true
    end,
    prompt_title = "Select file to add to question",
  })
end

return M

