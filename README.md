Installation
------------
Your first step is to clone this repository:

    git clone https://github.com/stevengonsalvez/dotfiles.git ~/.dotfiles

### Manual Installation
Create symbolic links for the configurations you want to use, e.g.:

    ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc


### Using [GNU Stow](https://www.gnu.org/software/stow/) _(recommended)_
Install GNU Stow _(if not already installed)_

    Mac:      brew install stow
    Ubuntu:   apt-get install stow
    Fedora:   yum install stow
    Arch:     pacman -S stow

Then simply use stow to install the dotfiles you want to use:

    cd ~/.dotfiles
    stow vim
    stow tmux
    stow .gnupg -t ~/.gnupg

##### ZSH
- uses powerlevel10k

## For npm global packages
#### Export
`npm list --global --parseable --depth=0 | sed '1d' | awk '{gsub(/\/.*\//,"",$1); print}' > path/to/npmfile`

#### Import
`xargs npm install --global < path/to/npmfile`

>current list
```
aicommits
corepack
delete-workflow-runs
dockerlint
http-server
json-log-viewer
npm
```