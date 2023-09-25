function is_in_distrobox() {
  if [[ -f /run/.containerenv ]]; then
    return 0
  else
    return 1
  fi
}

if ! is_in_distrobox && [[ $? -eq 0 ]] && ! type distrobox &>/dev/null; then
  print "[oh-my-zsh] distrobox plugin: shell function 'distrobox' not defined.\n" \
    "Please check distrobox" >&2
  return
fi

function distrobox_prompt_info {
  if is_in_distrobox; then
    echo "⬢ "
  else
    return 0
  fi
}

function distrobox_prompt_name {
  if is_in_distrobox; then
    echo "($CONTAINER_ID)"
  else
    return 0
  fi
}

function distrobox_name {
  # Get absolute path, resolving symlinks
  local PROJECT_ROOT="${PWD:A}"
  while [[ "$PROJECT_ROOT" != "/" && ! -e "$PROJECT_ROOT/.distrobox" &&
    ! -d "$PROJECT_ROOT/.git" ]]; do
    PROJECT_ROOT="${PROJECT_ROOT:h}"
  done

  # Check for distrobox name override
  if [[ -f "$PROJECT_ROOT/.distrobox" ]]; then
    echo "$(cat "$PROJECT_ROOT/.distrobox")"
  elif [[ -d "$PROJECT_ROOT/.git" ]]; then
    echo ""
  fi
}

# Automatically enter Git projects in the default distrobox container. Toolbox
# container can be overridden by placing a .distrobox file in the project root
# with a container name in it.
#
function distrobox_cwd {
  if [[ -z "$DISTROBOX_CWD" ]]; then
    local DISTROBOX_CWD=1
    local DISTROBOX_NAME=$(distrobox_name)

    if [[ -n $DISTROBOX_NAME ]]; then
      if ! is_in_distrobox; then
        if ! $(podman container exists $distrobox_NAME); then
          dbc $DISTROBOX_NAME
        fi
        distrobox enter $DISTROBOX_NAME
      fi
    elif [[ "$(hostname)" != "distrobox" && ! $DISABLE_TOOLBOX_EXIT -eq 1 ]]; then
      if is_in_distrobox; then
        exit
      fi
    fi
  fi
}

if [[ ! $DISABLE_DISTROBOX_ENTER -eq 1 ]]; then

  # Append workon_cwd to the chpwd_functions array, so it will be called on cd
  # http://zsh.sourceforge.net/Doc/Release/Functions.html
  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd distrobox_cwd
fi

alias dbc="distrobox create"
alias db="distrobox"
alias dbrm="distrobox rm"
alias dbrmi="distrobox rmi"
alias dbl="distrobox list"

function dbe {
  local DISTROBOX_NAME=$(distrobox_name)

  if [[ -n "$1" ]]; then
    DISTROBOX_NAME=$1
  elif [[ -z $DISTROBOX_NAME ]]; then
    DISTROBOX_NAME=
  fi

  distrobox enter $DISTROBOX_NAME
}

function dbr {
  local DISTROBOX_NAME=$(distrobox_name)

  if $(podman container exists $1); then
    DISTROBOX_NAME=$1
    shift
  elif [[ -z $DISTROBOX_NAME ]]; then
    DISTROBOX_NAME=
  fi

  distrobox-ephemeral $DISTROBOX_NAME "$@"
}
