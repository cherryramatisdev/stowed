local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'UbuntuMono Nerd Font Mono'
config.font_size = 20.0

config.color_scheme = 'Tomorrow (dark) (terminal.sexy)'

config.use_fancy_tab_bar = false

config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_decorations = "RESIZE"

local function get_current_working_dir(tab)
  local current_dir = tostring(tab.active_pane.current_working_dir or '')
  local HOME_DIR = string.format('file://%s', os.getenv('HOME'))

  if current_dir == HOME_DIR then
    return '~'
  else
    return string.gsub(current_dir, '(.*[/\\])(.*)', '%2')
  end
end

---@diagnostic disable-next-line: redefined-local
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local cwd = wezterm.format({
    { Attribute = { Intensity = 'Bold' } },
    { Text = get_current_working_dir(tab) },
  })

  return {
    { Text = string.format(' %s: %s ', tab.tab_index + 1, cwd) }
  }
end)

config.leader = { key="q", mods="CTRL" }

config.keys = {
  { key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "\\",mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "s", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "v", mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "o", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "c", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
  { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
  { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
  { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
  { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
  { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
  { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
  { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
  { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
  { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
  { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
  { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
  { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
  { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
  { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
  { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
  { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
  { key = "9", mods = "LEADER",       action=wezterm.action{ActivateTab=8}},
  { key = "&", mods = "LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
  { key = "d", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
  { key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
  { key = "[", mods = "LEADER",       action="ActivateCopyMode"},
  { key = "]", mods = "LEADER",       action=wezterm.action{PasteFrom="Clipboard"}},
  { key = "q", mods = "LEADER",       action="QuickSelect"},
}

local copy_mode = nil

if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  table.insert(
    copy_mode,
      {
        key = 'Enter',
        mods = 'NONE',
        action = wezterm.action.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'MoveToScrollbackBottom' },
          { CopyMode = 'Close' },
        },
      }
    )
end

config.key_tables = {
  copy_mode = copy_mode
}

return config
