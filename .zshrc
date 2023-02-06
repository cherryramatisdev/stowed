# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/Scripts
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting z)

source $ZSH/oh-my-zsh.sh

alias sync="stow . -t ~/"
alias chmox="chmod +x"
alias lg=lazygit
alias vi=nvim
alias e=exit
alias c=clear
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

bindkey -v
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"
