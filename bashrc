# region path
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/go/bin:$PATH" # go binaries
export PATH="$HOME/bin:$PATH" # personal bash scripts
source "$HOME/.cargo/env" # rust binaries
export COBOT_HOME=~/Documents/school/subjects/research/AlexaPrizeCobotToolkit
export PATH=$COBOT_HOME/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
# endregion

# region vim-bindings
export EDITOR=vim
set editing-mode vi
set -o vi
# endregion

# region third-party tools
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

if command -v rg 1>/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files'
fi

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# endregion

# region functions

cd () {
  builtin cd "$1" && ls -t | head -7
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
  grep --recursive --ignore-case --color --line-number --binary-files=without-match "$@"
}

who-owns() {
  ps -o user= -p "$1"
}

# endregion

# region aliases
alias dc=cd

alias rmds="find . -name '*.DS_Store' -type f -delete"

alias mv="mv -i"

alias dotenv='export "$(grep -v "#.*" .env | xargs)"'

alias clear='echo "Use CTRL-L"'

# endregion

# host specific stuff
if [ -f "$HOME/.hostrc" ]; then
  source "$HOME/.hostrc"
fi
