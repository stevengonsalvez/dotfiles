zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

source ~/.zshrc

gvm list
# need to install go1.4 to compile anything above go1.5
gvm install go1.4 -B

gvm use go1.4


gvm install go1.19
gvm use go1.19 --default


sudo ln -s $(which go) /usr/local/bin/go

go version

gvm pkgset create testgo
gvm pkgset use testgo --default
gvm pkgset list

mkdir -p $HOME/go $HOME/go/bin $HOME/go/src $HOME/go/pkg

gvm pkgenv testgo


## Add these to zshrc