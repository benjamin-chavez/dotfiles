return {
  {
    "spooky-scary",
    dir = vim.fn.stdpath("config") .. "/lua",
    lazy = false,
    priority = 1000,
    config = function()
      require("spooky-scary").setup()
    -- vim.cmd.colorscheme("spooky-scary")
    end,
  },
}
