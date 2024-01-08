# vim: syntax=zsh
if [[ -o interactive ]]; then
  export HISTSIZE=2000
  export HISTFILE=~/.zsh_history
  export SAVEHIST=2000
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  # nvim
  # export PATH="/users/aakash/nvim-0.6/squashfs-root/usr/bin:$PATH"

  # zsh add-ons
  source /local/tools/installs/setup/zshrc_4.8.0_simple
  
  # zsh-autosuggestions
  source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=green'
  
  # load modules
  # module load sw
  module load dv/l.dv2sw
  # module load hw
  # module load dv/l.dv1hw

  # set alias
  alias h='history'
  alias l='less'
  alias rm='rm -i'
  alias mv='mv -i'
  alias cp='cp -i'
  alias c='clear'
  alias ll='ls -l --color'
  alias lt='ls -ltr --color'
  alias ls='ls -sF --color'
  alias ssh='ssh -X'
  alias grep='egrep --colour -i'

  # custom alias
  alias tmux='tmux -u'
  alias cd-worka='cd /auto/worka/ishasivardhan/'

  setopt ignore_eof
  # setopt no_sharehistory
  setopt nullglob
  setopt inc_append_history
   
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/auto/tools/installs/ncurses/5.9/lib #DV1 kernel tool chain

fi
