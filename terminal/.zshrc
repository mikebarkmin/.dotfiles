# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME=$HOME/.config
export DOTFILES=$HOME/.dotfiles

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
PERSONAL=$XDG_CONFIG_HOME/personal
for i in `find -L $PERSONAL/env`; do
    source $i
done

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

plugins=(git virtualenv poetry-env pipenv pyenv zoxide nvm last-working-dir)

source $ZSH/oh-my-zsh.sh

# User configuration

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function workon() {
	nohup kitty --session ~/.config/kitty/sessions/$1 & disown
	exit
}

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=de_DE.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export PATH=~/.local/bin:$PATH
export PATH=~/.local/dbin:$PATH
export PATH=~/.local/share/gem/ruby/3.3.0/bin:$PATH

alias rm="trash"
alias ai="opencode"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export JDTLS_JVM_ARGS='-cp ".:./+libs/*"'

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function dot() {
	pushd $DOTFILES
	vim .
	popd
}

function dotc() {
	pushd $DOTFILES
	pushd personal
	git add .
	git commit -m "automagic message"
	git push origin main
	popd
	pushd demo
	git add .
	git commit -m "automagic message"
	git push origin main
	popd
	git add .
	git commit -m "automagic message"
	git push origin main
	popd
}

function confw() {
	pushd ~/.config/waybar/
	vim config.jsonc
	popd
}

function confh() {
	pushd ~/.config/hypr/
	vim hyprland.conf
	popd
}

function confsd() {
	pushd ~/.config/systemd/user/
	vim
	popd
}

function confv() {
	pushd ~/.config/nvim/
	vim
	popd
}

source "$HOME/.config/bpython/init.zsh"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# opencode
export PATH=/home/mike/.opencode/bin:$PATH
