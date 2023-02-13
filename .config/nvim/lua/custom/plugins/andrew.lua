return {
  {
    'AndrewRadev/sideways.vim',
    keys = {
      { "<c-h>", "<cmd>SidewaysLeft<cr>", desc = "Move item to left or up" },
      { "<c-l>", "<cmd>SidewaysRight<cr>", desc = "Move item to right or down" },
    },
  },
  'AndrewRadev/switch.vim',
  {
    'AndrewRadev/splitjoin.vim',
    keys = {
      {"gk", "<cmd>SplitjoinJoin<cr>", desc = "Join structure" },
      {"gj", "<cmd>SplitjoinSplit<cr>", desc = "Split structure" },
    },
    init = function()
      vim.g.splitjoin_split_mapping = ''
      vim.g.splitjoin_join_mapping = ''
    end
  },
}
