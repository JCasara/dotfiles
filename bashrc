# WARNING: THIS OVERRIDES BASH TO USE ZSH
# COMMENT THIS IF STATEMENT IF THIS BEHAVIOR
# IS NOT WANTED
# Start zsh if it's not already running
# if [ -z "$ZSH_VERSION" ]; then
#     exec zsh
# fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# share data with users in my group (ml)
umask 002

# Enable less to do syntax highlighting for various languages.
export LESS=' -R '

# Shell variables
export PROMPT_DIRTRIM=8
export HISTCONTROL=ignoredups:ignorespace:erasedups # no duplicate lines in the history.
export HISTSIZE=10000
export HISTFILESIZE=10000
#export HISTTIMEFORMAT='%s '
export EDITOR="emacs -nw"
export PAGER="less"

# xtrace can use the PS4 variable for to get usefull info about
# scripts you may be debugging
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

# Shell options
shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize # check the window size after each command

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


if [ -f ~/utils.sh ]; then
    source ~/utils.sh
fi


# Set the title of a Terminal window
function settitle() {
    if [ -n "$STY" ] ; then         # We are in a screen session
	echo "Setting screen titles to $@"
	printf "\033k%s\033\\" "$@"
	screen -X eval "at \\# title $@" "shelltitle $@"
    else
	printf "\033]0;%s\007" "$@"
    fi
}
function prompt ()
{
    settitle "$USER@$HOSTNAME:${PWD/$HOME/~}"
}

# for adding git branch to ps1
source ~/.git-prompt.sh

# Set prompt
case "$TERM" in
    xterm*|rxvt*)
    export PS1="\[$BGreen\]\u\[$OFF\]@\[$BYellow\]\h\[$OFF\]: \[$BBlue\]\w\[$OFF\] \[$BRed\]$(__git_ps1 " (%s)")\[$OFF\] \n\$ "
    # TILIX Support
    if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        # source /etc/profile.d/vte.sh
	source /etc/profile.d/vte-2.91.sh
    else
        export PROMPT_COMMAND=prompt
    fi
	;;
    dumb*)
	export PS1='\u@\h:\w\$ '
	;;
    *)
	;;
esac




# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias chte='sudo update-alternatives --config x-terminal-emulator'

alias zprofile='emacs ~/.zshrc'

alias fprofile='emacs ~/.config/fish/config.fish'

alias bprofile='emacs ~/.bashrc'
alias refresh='source ~/.bashrc'

alias tprofile='emacs ~/.tmux.conf'
alias vprofile='emacs ~/.vimrc'
alias aprofile='emacs ~/.config/alacritty/alacritty.yml'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[0;34m'        # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[1;93m'        # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;92m'       # begin underline

# added by Anaconda 2.2.0 installer
#export PATH="${HOME}/anaconda3/bin:$PATH"
#. ${HOME}/anaconda3/etc/profile.d/conda.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jcasara/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
   eval "$__conda_setup"
else
   if [ -f "/home/jcasara/anaconda3/etc/profile.d/conda.sh" ]; then
       . "/home/jcasara/anaconda3/etc/profile.d/conda.sh"
   else
       export PATH="/home/jcasara/anaconda3/bin:$PATH"
   fi
fi
unset __conda_setup
# <<< conda initialize <<<
activate pytorch3dunet


### export paths ###
export PATH=${HOME}/.local/bin:${PATH}
#export PATH="/usr/local/bin:$PATH" # this seems to get exported already

# jupiter lab path
#export JUPYTERLAB_DIR="$HOME/.local/share/jupyter/lab"

# new ssh banner
# only executes if SSH_TTY variable is set (i.e. connected via ssh)
if [ "x${SSH_TTY}" != "x" ]; then
    echo -e "$(cat /etc/ssh/banner)"
fi

# ROS setup
source /opt/ros/humble/setup.bash

# make r2 directory the place terminal begins
# unless you are opening another terminal from
# a location other than HOME
if [ $(pwd) == $HOME ]; then
    # cd $HOME/repos/redleader/r2
    cd $HOME/UnityProjects/RedLeader
fi

# export path to Qt6
export LD_LIBRARY_PATH=/usr/local/Qt6/lib:$LD_LIBRARY_PATH

# .NET framework
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

# start tmux
# [[ $TERM != "screen" ]] && exec tmux

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
