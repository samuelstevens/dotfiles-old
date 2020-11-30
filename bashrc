export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development

cd () {
	clear && builtin cd "$1" && ls -t | head -7
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
