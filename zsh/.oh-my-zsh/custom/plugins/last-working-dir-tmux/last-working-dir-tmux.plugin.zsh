# Flag indicating if we've previously jumped to last directory
typeset -g ZSH_LAST_WORKING_DIR_TMUX

# Updates the last directory once directory is changed
autoload -U add-zsh-hook
add-zsh-hook chpwd chpwd_last_working_dir_tmux

chpwd_last_working_dir_tmux() {
	if [ "$ZSH_SUBSHELL" = 0 ]; then
    local cache_dir="$ZSH_CACHE_DIR/last-working-dir-tmux"
    if [[ ! -d $cache_dir ]]; then
      mkdir -p $cache_dir
    fi
    tmux_session=$(tmux display -p '#S')
    if [[ ! -z $tmux_session ]]; then
      local cache_file_session="$ZSH_CACHE_DIR/last-working-dir-tmux/$tmux_session"
      pwd >| "$cache_file_session"
    fi
    local cache_file_global="$ZSH_CACHE_DIR/last-working-dir-tmux/global"
		pwd >| "$cache_file_global"
	fi
}

# Changes directory to the last working directory in this tmux session
lwd() {
  tmux_session=$(tmux display -p '#S')
  local cache_file_session="$ZSH_CACHE_DIR/last-working-dir-tmux/$tmux_session"
  local cache_file_global="$ZSH_CACHE_DIR/last-working-dir-tmux/global"
  if [[ ! -z $tmux_session && -r "$cache_file_session" ]]; then
    cd "$(cat "$cache_file_session")"
  elif [[ -r "$cache_file_global" ]]; then
    cd "$(cat "$cache_file_global")"
  fi
}

# Changes directory to the last working directory
lwd_global() {
  local cache_file_global="$ZSH_CACHE_DIR/last-working-dir-tmux/global"
	[[ -r "$cache_file_global" ]] && cd "$(cat "$cache_file_global")"
}

# Jump to last directory automatically unless:
# - this isn't the first time the plugin is loaded
# - it's not in $HOME directory
[[ -n "$ZSH_LAST_WORKING_DIR_TMUX" ]] && return
[[ "$PWD" != "$HOME" ]] && return

lwd 2>/dev/null && ZSH_LAST_WORKING_DIR_TMUX=1 || true
