# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# zsh theme: examples (robbyrussel, agnoster, etc)
ZSH_THEME="agnoster"

# Plugins
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
plugins=(
    archlinux
    colored-man-pages
    dirhistory
    docker
    git
    python
    tmux
    web-search
    vi-mode
    z
    zsh-autosuggestions
    )

source $ZSH/oh-my-zsh.sh

# Exports
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export ARCHFLAGS="-arch x86_64"

# https://askubuntu.com/questions/1393204/changing-zsh-autosuggestions-color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

# Check if vivid command is available
if command -v vivid &> /dev/null; then
    export LS_COLORS="$(vivid generate molokai)"
fi

export PYTHONBREAKPOINT="web_pdb.set_trace"

# Add cargo to path
export PATH="$HOME/.cargo/bin:$PATH"

# Setup tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"

# Share data with users in my group (ml)
umask 002

# Editor aliases
alias bprofile='$EDITOR ~/.bashrc'
alias aprofile='$EDITOR ~/.config/alacritty/alacritty.toml'
alias gprofile='$EDITOR ~/.gitconfig'
alias tprofile='$EDITOR ~/.tmux.conf'
alias vprofile='$EDITOR ~/.config/nvim'
alias zprofile='$EDITOR ~/.zshrc'
alias zrefresh='source ~/.zshrc'

alias vim='nvim'
alias vimdiff='vim -d'
alias jup='jupyter notebook 2>/dev/null' 

# Enable emacs in the terminal (No new window)
alias emacs='emacs -nw'

# Formatting and linting aliases
alias cf='git ls-files --exclude-standard -om \*{.cpp,.h} | xargs -n 1 -P $(nproc) clang-format -i --style=pep8'
alias cl='cpplint --recursive ./ | grep -Ev "Done processing|Ignoring"'

# Terminal Aliases
alias cat='bat --theme OneDark'
alias ls='exa --icons'
alias tree='exa --tree --level=2 --icons --color=always'

# Zoxide alias: function to use zshz_cd if attempting to return to previous directory
# else use zshz
cd() {
    if [[ "$1" == "-" ]]; then
        zshz_cd -
    else
        zshz "$@"
    fi
}

# ssh banner
# only executes if SSH_TTY variable is set (i.e. connected via ssh)
# if [ "x${SSH_TTY}" != "x" ]; then
#     echo -e "$(cat /etc/ssh/nbanner)"
# fi

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Tre
tre() { command tre "$@" -e "$EDITOR" && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

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
conda activate pytorch3dunet

# set core limit to unlimited for debug purposes
ulimit -c unlimited
