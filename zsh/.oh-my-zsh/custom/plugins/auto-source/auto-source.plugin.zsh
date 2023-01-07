autoload -U add-zsh-hook

load-local-conf() {
  if [[ -f .env && -r .env ]]; then
    echo "Found .env!"
    source .env
  fi
}

load-local-conf

add-zsh-hook chpwd load-local-conf
