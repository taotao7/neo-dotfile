#!/bin/bash

# Get the current command name
proc_name=$1

# Map commands to Nerd Font icons
case $proc_name in
    vim|nvim|vim*)    echo "" ;;
    git|lazy*)        echo "" ;;
    zsh|bash|sh)      echo "" ;;
    python*|py)       echo "" ;;
    node|npm|yarn)    echo "" ;;
    go)               echo "" ;;
    docker*|lazyd*)   echo "" ;;
    cargo|rust*)      echo "" ;;
    top|htop|btop)    echo "" ;;
    ssh)              echo "" ;;
    tmux)             echo "שׂ" ;;
    lf|ranger)        echo "" ;;
    *)                echo "" ;; # Default Terminal Icon
esac
