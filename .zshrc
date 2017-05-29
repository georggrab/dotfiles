# Language Settings
export LANG="en_US.UTF-8"
export TERM="rxvt-256color"

ZSH=$HOME/.oh-my-zsh

alias pacr='sudo pacman -Rns'
alias sim='sudo vim'
alias viartor='sudo -H -u t0r'
alias intercept='sudo tcpflow -i any -C -J port'

set -o vi

plugins=(git cabal archlinux web-search)

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
zstyle ':completion:*' menu select


function s () {
    echo $PWD >~/.last_dir
    echo "got it."
}

function r () {
    cd $(cat ~/.last_dir)
}

function proxy () {
    export HTTP_PROXY=localhost:3128
    export HTTPS_PROXY=localhost:3128
    export http_proxy=localhost:3128
    export https_proxy=localhost:3128
}

function proxy_off () {
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset http_proxy
    unset https_proxy
}

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k ]; then
	git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

ZSH_THEME="powerlevel9k/powerlevel9k"
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
proxy
source $ZSH/oh-my-zsh.sh
