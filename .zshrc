# Path to your oh-my-zsh configuration.
function print_icon(){}
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"

alias pacr='sudo pacman -Rns'
alias sim='sudo vim'
alias ya='yaourt --noconfirm'
alias viartor='sudo -H -u t0r'
alias intercept='sudo tcpflow -i any -C -J port'

set -o vi

plugins=(git cabal archlinux web-search)

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
zstyle ':completion:*' menu select

source $ZSH/oh-my-zsh.sh

function asmcmp () {
    local bnm=${$1%.*}
    nasm -f elf $1
    ld -m elf_i386 -s -o $bnm $bnm.o
}

function s () {
    echo $PWD >~/.last_dir
    echo "got it."
}

function r () {
    cd $(cat ~/.last_dir)
}

function lexcomp () {
    flex $1 && gcc lex.yy.c -lfl -o lex.out
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
