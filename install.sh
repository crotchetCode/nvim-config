#!/bin/bash

############################  BASIC SETUP TOOLS
msg() {
  printf '%b\n' "$1" >&2
}

success() {
  if ["$ret" -eq '0']; then
    msg "\33[32m[✔]\33[0m ${1}${2}"
  fi
}

error() {
  msg "\33[31m[✘]\33[0m ${1}${2}"
  exit 1
}

program_exists() {
  local ret='0'
  command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
      return 1
    fi

    return 0
  }

program_must_exist() {
  program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
      error "You must have '$1' installed to continue."
    fi
  }

variable_set() {
  if [ -z "$1" ]; then
    error "You must have your HOME environmental variable set to continue."
  fi
}

lnif() {
  if [ -e "$1" ]; then
    ln -sf "$1" "$2"
  fi
  ret="$?"
  debug
}


sync_repo() {
  local repo_path="$1"
  local repo_uri="$2"
  local repo_branch="$3"
  local repo_name="$4"

  msg "Trying to update $repo_name"

  if [ ! -e "$repo_path" ]; then
    mkdir -p "$repo_path"
    git clone -b "$repo_branch" "$repo_uri" "$repo_path"
    ret="$?"
    success "Successfully cloned $repo_name."
  else
    cd "$repo_path" && git pull origin "$repo_branch"
    ret="$?"
    success "Successfully updated $repo_name"
  fi

  debug
}

install_plug() {
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  }

init_env() {
  mv ../nvim-config $HOME/.config
  brew install python3
  pip3 install --user pynvim
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font
  brew install ripgrep
}

setup_vundle() {
  local system_shell="$SHELL"
  export SHELL='/bin/sh'

  nvim \
    "+set nomore" \
    "+PlugInstall!" \
    "+PlugClean" \
    "+qall"

  export SHELL="$system_shell"

  success "Now updating/installing plugins using vim-plug"
  debug
}

############################ MAIN()
variable_set "$HOME"
# program_must_exist "nvim"
program_must_exist "git"
program_must_exist "curl"

init_env
install_plug
setup_vundle
msg             "\nThanks for installing nvim power by zerocode."
msg             "© `date +%Y` /"

