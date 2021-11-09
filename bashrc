# This file is common between bash and zsh.
# For bash-specific stuff, use bash_profile
# For zsh-specific stuff, use zshrc

# region vim-bindings
set editing-mode vi
set -o vi
# endregion

# region third-party tools
if ! command -v starship 1>/dev/null 2>&1; then
  if ping -c 1 starship.rs 1>/dev/null 2>&1; then
    echo "Installing starhip prompt..."
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
  fi
fi

if command -v rg 1>/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files'
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

if ! command -v starship 1>/dev/null 2>&1; then
  if ping -c 1 starship.rs 1>/dev/null 2>&1; then
    echo "Installing starhip prompt..."
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
  fi
fi

# endregion

# host specific stuff
[ -f "$HOME/.hostrc" ] && source "$HOME/.hostrc"
