#!/usr/bin/env bash


set -g status-left "#[fg=#179299,bold,bg=#dce0e8]🐟 #H "
set -g status-right "#[fg=#4c4f69,bold,bg=#dce0e8]#S"
set -g window-status-current-format '#[fg=magenta,bg=#dce0e8] *#I #W'
set -g window-status-format '#[fg=gray,bg=#dce0e8] #I #W'
set -g window-status-last-style 'fg=white,bg=black'
set -g pane-active-border-style 'fg=magenta,bg=default'
set -g pane-border-style 'fg=brightblack,bg=default'
set -g status-style 'bg=#dce0e8' # transparent
