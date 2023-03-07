return {
  "nvim-orgmode/orgmode",
  config = function()
    -- Load custom treesitter grammar for org filetype
    require("orgmode").setup_ts_grammar()

    require("orgmode").setup {
      org_agenda_files = { "/Users/cherryramatis/Library/Mobile Documents/iCloud~md~obsidian/Documents/org" },
      org_default_notes_file = "/Users/cherryramatis/Library/Mobile Documents/iCloud~md~obsidian/Documents/org/refile.org",
    }
  end,
}
