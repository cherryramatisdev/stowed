fish_vi_key_bindings

# Check if Homebrew exists and load it if on macOS
if test -f "/opt/homebrew/bin/brew"
    /opt/homebrew/bin/brew shellenv | source
end

# Keybindings (Fish uses `bind`)
bind -M insert \cz 'fg'
bind -M insert \cg 'lazygit'
bind -M insert \ce 'end-of-line'
bind -M insert \cf 'walk'

# History settings
set -U fish_history
set -U fish_history_path ~/.local/share/fish/fish_history
set -U fish_greeting

# Env Vars
set -gx OBSIDIAN_VAULT "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/zettelkasten/Zettelkasten/"
set -gx EDITOR "vim"
set -gx GIT_EDITOR "$EDITOR"
set -gx PAGER "less"
set -gx PATH "$HOME/scripts" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PNPM_HOME "$HOME/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH

set -gx GOBIN "$HOME/.local/bin/"

function fish_prompt
  echo "🍒 "
end

set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix'

set -gx NIX_CONF_DIR "$HOME/.config/nix"

# GraalVM setup
set -gx GRAALVM_HOME "$HOME/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.0.0.2/Contents/Home"
set -gx PATH "$GRAALVM_HOME/bin" $PATH

# Aliases
alias task="ultralist"
alias t="tmux"
alias ls="ls --color"
alias ll="ls --color -l"
alias la="ls --color -lha"
alias l="ls --color"
alias c="clear"
alias f="fzf --bind='enter:execute@vim {}@+abort'"
alias ca="cargo"
# alias "?"="websearch"
alias gg="git grep -n"
alias gl="~/scripts/gup"
alias postgresup="docker run --rm --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e TZ=America/Sao_Paulo -d postgres"
alias postgresdown="docker stop postgres"
alias postgresconnect="docker exec -it postgres psql -U postgres"
alias dsp="docker system prune -a"
alias tmp="cd (mktemp -d /tmp/XXXXXX)"
alias zettel="cd ~/Library/Mobile Documents/com~apple~CloudDocs/Documents/zettelkasten/Zettelkasten"
alias chromewithoutcors='open -n -a "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias b="bundle"
alias ba="bundle add"
alias be="bundle exec"

# Shell integrations
function _has_binary
    command -v $argv[1] > /dev/null 2>&1
end

if _has_binary "zoxide"
    eval (zoxide init fish)
end

if _has_binary "dstask"
    eval (dstask fish-completion)
end

if _has_binary "asdf"
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
end

if _has_binary "mise"
    eval (mise activate fish)
end

# bun
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH "$BUN_INSTALL/bin" $PATH

set -gx PATH "$HOME/.ghcup/bin" $PATH
set -gx PATH "$HOME/.cabal/bin" $PATH

set -x CDPATH $HOME/git/personal $HOME/git/work .
