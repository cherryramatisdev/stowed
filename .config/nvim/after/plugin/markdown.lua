MiniDeps.add {
  source = "jbyuki/venn.nvim",
}

-- venn.nvim: enable or disable keymappings
local function toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd [[setlocal ve=all]]
    vim.cmd [[setlocal conceallevel=0]]
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
  else
    vim.cmd [[setlocal ve=]]
    vim.api.nvim_buf_del_keymap(0, "n", "J")
    vim.api.nvim_buf_del_keymap(0, "n", "K")
    vim.api.nvim_buf_del_keymap(0, "n", "L")
    vim.api.nvim_buf_del_keymap(0, "n", "H")
    vim.api.nvim_buf_del_keymap(0, "v", "f")
    vim.b.venn_enabled = nil
  end
end

---@param label string
local function draw_rect(label)
  local len = label:len()

  local feed = function(key)
    vim.cmd(string.format([[ call feedkeys("%s") ]], key))
  end

  local feed_with_special = function(key)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), "m", true)
  end

  -- First type the literal label
  feed("i" .. label)

  feed_with_special "<esc>"

  -- Move to the beginning of the word + 1 character
  feed((len + 1) .. "h")

  -- Move up 2 chars
  feed "1k"

  feed_with_special "<c-v>"

  -- And then move down 3
  feed "2j"

  -- And move the len of the word + 3
  feed((len + 3) .. "l")

  feed "f"
end

vim.keymap.set("n", "<leader>v", toggle_venn)

vim.keymap.set("n", "<leader>r", function()
  local label = require("str").trim(vim.fn.input "Label: ")

  if label then
    draw_rect(label)
  end
end)
