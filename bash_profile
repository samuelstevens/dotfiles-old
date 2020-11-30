#!/usr/bin/env bash

[[ -s ~/.bashrc ]] && source ~/.bashrc

set -o vi

export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$HOME/go/bin:$PATH" # go binaries
export PATH="$HOME/bin:$PATH" # personal bash scripts

export GITAWAREPROMPT=~/.bash/git-aware-prompt

source "${GITAWAREPROMPT}/main.sh"


# tracms box
alias ssh-tracms="ssh stevens.994@tracms.asc.ohio-state.edu"
alias ssh-healthyagers="ssh stevens.994@healthyagers.asc.ohio-state.edu"

# prompt
export PS1="\h:\W \u \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export PS1="\u@\h \W \[\$txtcyn\]\$git_branch\[\$txtred\]\$git_dirty\[\$txtrst\]\$ "
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

alias venv=". venv/bin/activate"
alias dotenv='export "$(grep -v "#.*" .env | xargs)"'

macnst (){
    netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"
}

syspip () {
  PIP_REQUIRE_VIRTUALENV="" pip --isolated "$@"
}

wifi(){
  enabled=$(networksetup -getairportpower en0)

  if [[ $enabled == *"On"* ]]; then
    networksetup -setairportpower en0 off
    echo "Wifi is now disabled."
  else
    networksetup -setairportpower en0 on
    echo "Wifi is now enabled."
  fi
}

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

clean() {
  xcrun simctl delete unavailable
}
