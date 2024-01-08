# these are the commands I add to my bash config at ~/.bashrc
# make this script executable and source this file at the end of bash config file (add following line)
# . ~/my-ubuntu-stuff/my-scripts/mybash.sh

# any commands like setting environment variables etc.
export PROMPT_DIRTRIM=2

# alias for VSCodium
# alias code=codium

# alias for xclip to copy to system clipboard
alias "xclip=tr -d '\n'|xclip -selection clipboard"
