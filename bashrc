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
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v rg 1>/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files'
fi

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# endregion

# region functions

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

  echo "No venv/ in $(pwd)."
  
  if [[ -f .python-version ]]; then
    echo "Making a new one with $(python3 --version)"
    python3 -m venv venv
    source venv/bin/activate
    pip install --upgrade pip
    return
  elif command -v conda > /dev/null; then
    conda_packages=$(conda env list | awk '/^[^#]/ {print $1}')
    dir=$(basename $(pwd))
    echo "conda is installed; checking for a conda environment matching $dir."
    echo $conda_packages | grep -w -q $dir
    if [[ $? -eq 0 ]]; then
      echo "Found conda environment '$dir'; activating now."
      conda activate $dir
    else
      echo "Couldn't find a conda environment with name $dir"
    fi
  else
    echo "No .python-version file; will not make a virtualenv without knowing which version of python to use."
  fi

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

