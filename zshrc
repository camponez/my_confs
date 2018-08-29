# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="my_bira"
#ZSH_THEME="my_avit"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(bundler git git-extras git-flow gitignore git-prompt gitfast command-not-found ruby ssh-agent tmux fast-syntax-highlighting docker python cp docker docker-compose fzf-zsh)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

#source "$HOME/.antigen/antigen.zsh"
#
#antigen-use oh-my-zsh
#antigen-bundle arialdomartini/oh-my-git
#antigen theme arialdomartini/oh-my-git-themes oppa-lana-style
#
#antigen-apply

#source $ZSH/custom/zshrc.sh
source $ZSH/oh-my-zsh.sh

source $HOME/devel/zsh-git-prompt/zshrc.sh
#export PROMPT='%B%m%~%b$(git_super_status) %# '

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

######## ALIASES
alias p='ps xwu --forest'
alias rm='rm -v'
alias cp='cp -vi'
alias du='du -hs'
alias mv='mv -v'
alias gvim='vim -g -b'
alias grep='grep -n --color=auto'
alias chmod='chmod -v'
alias gpg='gpg2'
alias lockme='xscreensaver-command -lock'
alias tmux='tmux -2'
alias cdd='cd $(ls -d */ | fzf)'
alias fixscreen="xrandr --output eDP-1 --right-of DP-1-2"


export PATH="$PATH:$HOME/local/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


set -o HIST_IGNORE_ALL_DUPS
set -o HIST_IGNORE_SPACE
set -o PUSHDSILENT

stty -ixon
eval $(dircolors ~/.dir_colors)
xmodmap $HOME/.Xmodmap

export CFLAGS="-march=native -O2 -pipe"
export CXXFLAGS="${CFLAGS}"

export GTK_IM_MODULE=cedilla

# source $HOME/devel/tmuxinator/completion/tmuxinator.zsh
# export GOROOT=$HOME/local/go
# export PATH="$HOME/local/bin:$GOROOT/bin:$PATH"

source /usr/bin/virtualenvwrapper.sh
if [ -f $HOME/.local_vars ]; then
    source ~/.local_vars
fi
