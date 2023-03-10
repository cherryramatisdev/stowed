# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/Scripts
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export PNPM_HOME="/Users/cherryramatis/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH=~/.npm-global/bin:$PATH

export EDITOR="nvim"
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"

if [[ $VIM != "" ]]; then
  export EDITOR="viedit"
fi

# Setup jira
export JIRA_TOKEN="$(jq '.token' ~/.jiraconfig.json | sed 's/"//g')"
export JIRA_USER="$(jq '.email' ~/.jiraconfig.json | sed 's/"//g')"
export JIRA_URL="$(jq '.url' ~/.jiraconfig.json | sed 's/"//g')"
export JIRA_CARD_PREFIX="$(jq '.prefix' ~/.jiraconfig.json | sed 's/"//g')"
export JIRA_PROFILE_ID="$(jq '.profile_id' ~/.jiraconfig.json | sed 's/"//g')"
export REVIEWERS="$(cat ~/Repos/stowed/reviewers | tr '\n' , | sed 's/,$//')"

# setup fnm(https://github.com/Schniz/fnm)
eval "$(fnm env --use-on-cd)"

# setup zoxide
eval "$(zoxide init zsh)"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-autosuggestions colored-man-pages history sudo fzf rbenv gem tmux rails brew)

source $ZSH/oh-my-zsh.sh

alias sync="stow . -t ~/"
alias chmox="chmod +x"
alias lg=lazygit
alias vi="$EDITOR"
alias v="vim"
alias gp="~/Scripts/gp"
alias gup="~/Scripts/gup"
alias cat="bat"
alias t="~/Scripts/tmuxsessionizer"
alias e=exit
alias clear='printf "\e[H\e[2J"'
alias c='printf "\e[H\e[2J"'
alias b='bundle'
alias be='bundle exec' 
alias ba='bundle add'
alias depupdate="yarn upgrade-interactive --latest"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

bindkey -v
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/cherryramatis/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
export PATH="/opt/homebrew/opt/ruby@3.1/bin:$PATH"
