#!/usr/bin/env bash

set -g status-left "#[fg=blue,bold,bg=#1e1e2e]🐟 #H "
set -g status-right "#[fg=#b4befe,bold,bg=#1e1e2e]#S"
set -g window-status-current-format '#[fg=magenta,bg=#1e1e2e] *#I #W'
set -g window-status-format '#[fg=gray,bg=#1e1e2e] #I #W'
set -g window-status-last-style 'fg=white,bg=black'
set -g pane-active-border-style 'fg=magenta,bg=default'
set -g pane-border-style 'fg=brightblack,bg=default'
set -g status-style 'bg=#1e1e2e' # transparent
