# vim-cloud9-themes
These are the cloud9 themes from the [cloud9 IDE](http://c9.io). If you watched the railstutorial.org screencasts you might be used to the 'cloud9 night' which is used in the videos and is the default cloud9 ide theme. This is a copy of that theme for vim.
### Screenshots:
![](http://i.imgur.com/Qalar5U.png ".erb file")
![](http://i.imgur.com/A4iDZ25.png ".rb file")
![](http://i.imgur.com/gKnxjSp.png "Tests file")
### Instalation:
##### [neobundle.vim](https://github.com/Shougo/neobundle.vim) :
add this line to your .vimrc or neovim configuration file (usually it is in '~/.config/nvim/init.vim'):
```sh
NeoBundle 'tiagofumo/vim-cloud9-themes'
colorscheme cloud9-night
```
### Dependencies
This plugin assumes you have vim-ruby (that comes with polyglot, so if you have polyglot you don't need to add it) and vim-rails. So if you are doing a ruby on rails app, you should have those plugins installed.
### Usage
```sh
:colorscheme cloud9-night
```
or add that (without the :) to your .vimrc file or nvim equivalent.
