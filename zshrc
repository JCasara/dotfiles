# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=( "sunaku" "fletcherm")
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"
# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    archlinux
    colored-man-pages
    docker
    git
    zsh-autosuggestions
    python
    tmux
    web-search
    vi-mode)
source $ZSH/oh-my-zsh.sh
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
# Compilation flags
export ARCHFLAGS="-arch x86_64"
export PATH="$HOME/.cargo/bin:$PATH"
#List of options for TERM variable: /usr/lib/terminfo
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# Share data with users in my group (ml)
umask 002

# Some useful aliases
alias vimdiff='vim -d'
alias zprofile='vim ~/.zshrc'
alias refresh='source ~/.zshrc'

alias fprofile='vim ~/.config/fish/config.fish'
alias bprofile='vim ~/.bashrc'

alias tprofile='vim ~/.tmux.conf'
alias vprofile='vim ~/.config/nvim'

alias cls='clear'
alias aprofile='nvim ~/.config/alacritty/alacritty.toml'
alias kprofile='nvim ~/.config/kitty/kitty.conf'
alias jup='jupyter notebook 2>/dev/null' 
alias emacs='emacs -nw'

# https://askubuntu.com/questions/1393204/changing-zsh-autosuggestions-color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"
export LS_COLORS="$(vivid generate molokai)"
export PYTHONBREAKPOINT="web_pdb.set_trace"

alias cf='git ls-files --exclude-standard -om \*{.cpp,.h} | xargs -n 1 -P $(nproc) clang-format -i --style=pep8'
alias cl='cpplint --recursive ./ | grep -Ev "Done processing|Ignoring"'
alias cat=bat
alias ls='exa --icons'
alias tree='exa --tree --level=2 --icons --color=always'
# alias cd='z'

# new ssh banner
# only executes if SSH_TTY variable is set (i.e. connected via ssh)
# if [ "x${SSH_TTY}" != "x" ]; then
#     echo -e "$(cat /etc/ssh/nbanner)"
# fi

# Setup tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"

# Begin TMUX
# if [ $TERM != "screen-256color" ]; then
#     exec tmux
# fi
# [ -z "$TMUX" ] && {exec tmuxifier load-session dd}

# [ -z "$TMUX" ] && { tmux attach; }

#source /opt/ros/noetic/setup.bash

# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Tre
tre() { command tre "$@" -e "$EDITOR" && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

eval "$(zoxide init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jcasara/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
conda activate dsic
