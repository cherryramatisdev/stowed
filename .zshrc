if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# # Set the directory we want to store zinit and plugins
# ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# # Download Zinit, if it's not there yet
# if [ ! -d "$ZINIT_HOME" ]; then
#    mkdir -p "$(dirname $ZINIT_HOME)"
#    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# fi

# # Source/Load zinit
# source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
# zinit light zsh-users/zsh-syntax-highlighting
# zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab

# Add in snippets
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo

# Load completions
# autoload -Uz compinit && compinit

# zinit cdreplay -q

# Keybindings
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line

bindkey -s "^Z" 'fg^M'
bindkey -s "^G" 'lazygit^M'

# Vi style:
bindkey "^F" edit-command-line
bindkey -M vicmd "^F" edit-command-line
bindkey -M vicmd v edit-command-line
bindkey "^e" end-of-line

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Env Vars
export OBSIDIAN_VAULT="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/zettelkasten/Zettelkasten/"
export EDITOR="vim"
export GIT_EDITOR="$EDITOR"
export PAGER="less"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

export PS1="🍒 "

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

export NIX_CONF_DIR=$HOME/.config/nix

# https://maksimrv.medium.com/install-graalvm-on-macos-m1-1f7812a29c75
export GRAALVM_HOME="$HOME/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.0.0.2/Contents/Home"
export PATH="$GRAALVM_HOME/bin:$PATH"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias task="ultralist"
alias t="tmux"
alias ls='ls --color'
alias ll='ls --color -l'
alias la='ls --color -lha'
alias l='ls --color'
alias c='clear'
alias f='fzf --bind="enter:execute@vim {}@+abort"'
alias ca='cargo'
alias '?'='websearch'
alias gg='git grep -n'
alias gl='~/scripts/gup'
alias postgresup='docker run --rm --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e TZ=America/Sao_Paulo -d postgres'
alias postgresdown='docker stop postgres'
alias postgresconnect='docker exec -it postgres psql -U postgres'
alias dsp='docker system prune -a'
alias tmp='cd "$(mktemp -d /tmp/XXXXXX)"'
alias zettel='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/zettelkasten/Zettelkasten'
alias chromewithoutcors='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias b='bundle'
alias ba='bundle add'
alias be='bundle exec'
# unalias 'gp'

# Shell integrations
_has_binary() {
    command -v "$1" >/dev/null 2>&1
}

# _has_binary "fzf" && eval "$(fzf --zsh)"
_has_binary "zoxide" && eval "$(zoxide init --cmd cd zsh)"
_has_binary "dstask" && eval "$(dstask zsh-completion)"
_has_binary "asdf" && . /opt/homebrew/opt/asdf/libexec/asdf.sh
_has_binary "mise" && eval "$(mise activate zsh)"
_has_binary "cargo" && . "$HOME/.cargo/env"

# bun completions
[ -s "/Users/cherryramatis/.bun/_bun" ] && source "/Users/cherryramatis/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Load Angular CLI autocompletion.
_has_binary "ng" && source <(ng completion script)

[ -f "/Users/cherryramatis/.ghcup/env" ] && . "/Users/cherryramatis/.ghcup/env" # ghcup-env

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
