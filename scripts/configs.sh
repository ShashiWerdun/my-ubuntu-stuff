#!/bin/bash

# tmux config
tmux_config_path=`realpath ../config/tmux.conf`
find_tmux_config=`find ~ -maxdepth 1 -name .tmux.conf`
if [[ ${#find_tmux_config} -eq 0 ]]
then
    ln -s $tmux_config_path ~/.tmux.conf
else
    echo "found tmux config at $find_tmux_config"
fi

# vim config
vimrc_path=`realpath ../config/vimrc`
find_vimrc=`find ~ -maxdepth 1 -name .vimrc`
if [[ ${#find_vimrc} -eq 0 ]]
then
    ln -s $vimrc_path ~/.vimrc
else
    echo "found vim config at $find_vimrc"
fi
