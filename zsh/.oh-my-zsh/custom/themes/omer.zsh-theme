CRUNCH_BRACKET_COLOR="%{$fg[white]%}"
CRUNCH_RVM_COLOR="%{$fg[magenta]%}"
CRUNCH_DIR_COLOR="%{$fg[cyan]%}"
CRUNCH_GIT_BRANCH_COLOR="%{$fg[green]%}"
CRUNCH_GIT_CLEAN_COLOR="%{$fg[green]%}"
CRUNCH_GIT_DIRTY_COLOR="%{$fg[red]%}"

# These Git variables are used by the oh-my-zsh git_prompt_info helper:
ZSH_THEME_GIT_PROMPT_PREFIX="$CRUNCH_BRACKET_COLOR:${CRUNCH_GIT_BRANCH_COLOR}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_CLEAN=" $CRUNCH_GIT_CLEAN_COLOR✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" $CRUNCH_GIT_DIRTY_COLOR✗"

# Our elements:
CRUNCH_DIR_="$CRUNCH_DIR_COLOR%~\$(git_prompt_info) "
CRUNCH_PROMPT="$CRUNCH_BRACKET_COLOR"

# Put it all together!
USER_="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}"

local venv_prompt='$(virtualenv_prompt_info)'
local distrobox_prompt_info='$(distrobox_prompt_info)'
local distrobox_prompt_name='$(distrobox_prompt_name)'

# Prompt without user prefix
PROMPT="${distrobox_prompt_info}$CRUNCH_DIR_$CRUNCH_PROMPT%{$reset_color%}"
RPROMPT="${venv_prompt}${distrobox_prompt_name}"
