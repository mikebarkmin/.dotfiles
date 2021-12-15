# Dotfiles

## Getting Started

My `dotiles` are managed by `stow`. So you need that before continuing. You also need `git-crypt` for the private
`personal` and `work` submodule. These contain information not for the public eyes. You can take a look at the `demo`
submodule to get an idea how these work.

## Installation

Clone this repository.

```
git clone https://github.com/mikebarkmin/.dotfiles.git
```

You can install three variants of the dotfiles.

| Variant | Installation | Description |
|-----|----|----|
| demo | `./install-demo` | Just for demonstration |
| personal | `./install-personal` | Personal config |
| work | `./install-work` | Work config |

For personal and work use private repositories which are encrypted with `git-crypt`. So, you also need the correct pgp
key.

## Auto Installation and Setup

You can use this script to automatic setup a Fedora Silverblue installation.

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mikebarkmin/silberblau/main/bin/install.sh)
```

For more information visit the [silberblau repository](https://github.com/mikebarkmin/silberblau).

## Inspiration

The dotfiles took inspiration mainly from [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles) to the point that I
have blatantly copied files over to my repo.
