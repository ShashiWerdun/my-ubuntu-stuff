#!/bin/bash

# tmux config
tmux_config_path=`realpath ./tmux.conf`
find_tmux_config=`find ~ -name .tmux.conf`
if [[ ${#find_tmux_config} == 0 ]]; then
    ln -s $tmux_config_path ~/.tmux.conf
fi;

# vim config
vimrc_path=`realpath ./vimrc`
find_vimrc=`find ~ -name .vimrc`
if [[ ${#find_vimrc} == 0 ]]; then
    ln -s $vimrc_path ~/.vimrc
fi;
