#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='exa'
alias cat='bat'
eval "$(starship init bash)"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MICRO_TRUECOLOR=1
