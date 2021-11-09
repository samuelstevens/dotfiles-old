export ZDOTDIR="$HOME/.zsh"
export EDITOR="vim"

export HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
export SAVEHIST=10000
export HISTSIZE=10000

for file in $(find -L $HOME/.shared); do
  source $file
done
