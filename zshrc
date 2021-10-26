# shell options
setopt NO_CASE_GLOB
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
# expands !! before executing
setopt HIST_VERIFY

unsetopt correct
unsetopt correct_all
DISABLE_CORRECTION="true"

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000

# common between bash and zsh

if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi

# Autocomplete
fpath+=~/.zfunc

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix

# vim bindings 
bindkey -v

# third-party tools

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide
if command -v zoxide 1>/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# If cd takes forever, then consider setting this command once, rather than upon every invocation.
cd() {
    if [[ $(whence -w __zoxide_z) == "__zoxide_z: function" ]]; then
        __zoxide_z "$@"
    else
        builtin cd "$@"
    fi
}

# prompts
eval "$(starship init zsh)"

