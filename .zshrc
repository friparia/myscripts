# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
# ZSH_THEME="geoffgarside"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(colorize git git-flow laravel4 composer autojump)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/Users/friparia/go/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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
alias gt="git status"
alias gca="git commit -a"
alias gc="git checkout"
alias gb="git branch"
alias gl="git log --graph --color"
alias a="git commit -am"
alias n="git checkout -b"

function p () {
  branch=`get_main_branch`
  git checkout $branch && git pull origin $branch
}

function get_main_branch() {
  branch=`git config branch.main`
  if [ -z $branch ] ; then 
    vared -p 'Please enter your main push branch: ' -c branch
    git config branch.main $branch
  fi
  echo $branch
}

function q () {
  branch=`get_main_branch`
  current_branch=`git branch | awk '$1=="*" {print $2}'`
  if [[ -n `git status | grep 'nothing to commit'` ]]; then
    echo "nothing to commit!"
  else
    information=("${(@s/-/)current_branch}")
    a "$information"
  fi
  git checkout $branch && git pull origin $branch && git checkout $current_branch && git rebase $branch && git checkout $branch && git merge --no-ff $current_branch && git push origin $branch && git branch -d $current_branch
}

function f (){
    vared -p 'Please enter your commit message: ' -c message
    branch=${message// /-}
    n $branch
    q
}

_s_get_command_list () {
  cat ~/.ssh/config | sed '/^ /d' | awk '{print $2}'
}

_s_get_required_list () {
  #不知道干嘛的
}

_s () {
  local curcontext="$curcontext" state line
  typeset -A opt_args
  _arguments \
    '1: :->command'\
    '*: :->args'

  case $state in
    command)
      compadd $(_s_get_command_list)
      ;;
    *)
      compadd $(_s_get_required_list)
      ;;
  esac
}


s (){
  local name=$1
  shift
  if [[ $@ = "" ]]; then
    ssh $name
  else
    local port=22
    local identity=""
    local option=()
    local host=""
    while [[ $# -gt 0 ]]
    do
      key="$1"
      case $key in
        -p)
          port="$2"
          shift 
          shift 
          ;;
        -i)
          identity="$2"
          shift 
          shift 
          ;;
        -o)
          option+=("-o $2")
          shift 
          shift 
          ;;
        *)   
          host=$1
          shift 
          ;;
      esac
    done
    exist=`cat ~/.ssh/config | grep "Host $name"`
    method="edit"
    if [[ $exist = "" ]]; then
      method="add"
    fi
    if [[ $identity = ""  ]]; then
      storm $method $name $host:$port $option
    else
      storm $method $name $host:$port --id_file $identity $option
    fi
    ssh $name
  fi
}


function up () {
  sh ~/myscripts/upload.sh
}


function update () {
  cd ~/myscripts
  git pull
  sh ~/myscripts/update.sh
}
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

case "$TERM" in
  "dumb")
    PS1="> "
    ;;
  xterm*|rxvt*|eterm*|screen*)
    PS1='%{%f%b%k%}$(build_prompt) '
    ;;
  *)
    PS1="> "
    ;;
esac

compdef _s s
