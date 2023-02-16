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

## For pip installs

`pip list`
`pip freeze`

Current list

```
aiohttp==3.8.4
aiosignal==1.3.1
async-timeout==4.0.2
attrs==22.2.0
certifi==2022.12.7
charset-normalizer==3.0.1
frozenlist==1.3.3
idna==3.4
Jinja2==3.1.2
junit2html==30.1.3
MarkupSafe==2.1.2
multidict==6.0.4
openai==0.26.5
requests==2.28.2
tqdm==4.64.1
urllib3==1.26.14
yarl==1.8.2
```