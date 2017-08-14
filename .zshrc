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

export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
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
alias gh="git push origin dev-8"
alias -g fuck="  && sed -i '6s/127.0.0.1/10.3.19.151/g' config/config.php && git update-index --assume-unchanged config/config.php && git update-index --assume-unchanged ../wrd.asc"
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

function test_host () {
  for port in "22" "13911"
  do
    for prefix in "10.3.19." "10.3." ""
    do
      for user in "root"
      do
        for key in "id_rsa"
        do
          server="$prefix$1"
          `ssh -o ConnectTimeout=5 -o BatchMode=yes -p$port -i ~/.ssh/$key $user@$server exit`
          if [[ $? -eq 0 ]];then
            echo "Host $1"
            echo "  HostName $server"
            echo "  Port $port"
            echo "  User $user"
            echo "  IdentityFile ~/.ssh/$key"
            return 0
          fi
        done
      done
    done
  done
}

function s (){
  test=`ssh -o ConnectTimeout=5 $1 exit`
  if [[ $? -eq 0 ]];then
    ssh $1
  else
    config=`test_host $1`
    if [[ -n $config ]]; then
      echo $config >> ~/.ssh/config
      ssh $1
    fi
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
