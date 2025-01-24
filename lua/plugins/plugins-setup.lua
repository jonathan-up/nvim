local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 保存此文件自动更新安装软件
-- 注意PackerCompile改成了PackerSync
-- plugins.lua改成了plugins-setup.lua，适应本地文件名字
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  -- packer 主体
  use 'wbthomason/packer.nvim'

  -- tokyo 主题
  use 'folke/tokyonight.nvim'

  -- 底部状态栏 + ICON
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- 文档树 + ICON
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  }

  -- 用ctl-hjkl来定位窗口
  use "christoomey/vim-tmux-navigator"

  -- 语法高亮 + 彩虹括号
  use "nvim-treesitter/nvim-treesitter"
  use "p00f/nvim-ts-rainbow"

  if packer_bootstrap then
    require('packer').sync()
  end
end)
