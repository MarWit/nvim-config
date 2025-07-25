local lint = require('lint')

lint.linters_by_ft = {
  cs = {'typos', },
  python = {'typos', },
  rust = {'typos', },
  markdown = {'languagetool', },
  rst = {'languagetool', },
  treesitter = {'treesitter', },
  sh = {'shellcheck', },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
