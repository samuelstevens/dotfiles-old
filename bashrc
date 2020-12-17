# path
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/go/bin:$PATH" # go binaries
export PATH="$HOME/bin:$PATH" # personal bash scripts
# export PATH="$HOME/anaconda3/bin:$PATH"  # commented out by conda initialize # anaconda3

# vim-bindings
export EDITOR=vim
set editing-mode vi
set -o vi

# third-party tools
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# functions

cd () {
  clear && builtin cd "$1" && ls -t | head -7
}

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

clean() {
  xcrun simctl delete unavailable
}

venv() {
  if [[ -d venv ]]; then
    source venv/bin/activate 
    return
  fi

  echo "No venv/ in $(pwd)"
  
  if [[ -f .python-version ]]; then
    echo "Making a new one with $(python --version)"
    python3 -m venv venv
    source venv/bin/activate  
    pip install --upgrade pip
    return
  fi

  echo "No .python-version file; will not make a virtualenv without knowing which version of python to use."
}

marco() {
  pwd > /tmp/marco 
}

polo() {
  cd $(cat /tmp/marco)
}

mygrep() {
  # adds some reasonable defaults to grep on systems where ripgrep can't be installed
  grep --recursive --ignore-case --color --line-number --binary-files=without-match $@
}

# aliases
alias dc=cd

alias rmds="find . -name '*.DS_Store' -type f -delete"

alias mv="mv -i"

alias dotenv='export "$(grep -v "#.*" .env | xargs)"'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/stevens.994/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/stevens.994/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/stevens.994/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/stevens.994/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

