#!/bin/bash

# Get the current command name
proc_name=$1

# Map commands to Nerd Font icons (FontAwesome + Devicons)
case $proc_name in
    vim|nvim|vim*)    echo "" ;;
    git|lazy*)        echo "" ;;
    zsh|bash|sh)      echo "" ;;
    python*|py)       echo "" ;;
    node|npm|yarn|pnpm) echo "" ;;
    go)               echo "" ;;
    docker*|lazyd*)   echo "" ;;
    cargo|rust*)      echo "" ;;
    top|htop|btop)    echo "" ;;
    ssh)              echo "" ;;
    tmux)             echo "" ;;
    lf|ranger)        echo "" ;;
    java|mvn|gradle)  echo "" ;;
    ruby|irb)         echo "" ;;
    php)              echo "" ;;
    lua)              echo "" ;;
    perl)             echo "" ;;
    make|cmake)       echo "" ;;
    mysql|psql)       echo "" ;;
    redis*)           echo "" ;;
    mongo*)           echo "" ;;
    kubectl|k9s)      echo "" ;;
    terraform)        echo "" ;;
    *)                echo "" ;; # Default Terminal Icon
esac
