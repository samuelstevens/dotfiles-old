#!/usr/bin/env bash

if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi

# clear screen with set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# region third-party tools

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

# endregion

# region very old aliases just in case

# tracms box
alias ssh-tracms="ssh stevens.994@tracms.asc.ohio-state.edu"
alias ssh-healthyagers="ssh stevens.994@healthyagers.asc.ohio-state.edu"

# endregion

# region prompt
export PS1="\W \[\$txtcyn\]\$git_branch\[\$txtred\]\$git_dirty\[\$txtrst\]\$ "
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

# endregion

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

if command -v zoxide 1>/dev/null 2>&1; then
  eval "$(zoxide init --cmd j bash)"
fi

# If cd takes forever, then consider setting this command once, rather than upon every invocation.
cd() {
    if [[ $(type -t __zoxide_z) == "function" ]]; then
        __zoxide_z "$@"
    else
        builtin cd "$@"
    fi
}
