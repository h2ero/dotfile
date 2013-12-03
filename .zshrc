# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="h2ero"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#
export GOPATH='/home/h2ero/h2ero/code/mygo/'
export PATH=$PATH:/home/h2ero/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$GOPATH/bin:/home/h2ero/bin/bin:$GOPATH/bin:/home/h2ero/bin/go/bin


################################################################
#
#
#
#
#
################################################################

    set -o vi
#exprot
    export EDITOR="vim"
     
    export LANG="zh_CN.UTF-8"
    export LANGUAGE=
    export LC_CTYPE="zh_CN.UTF-8"
    export LC_NUMERIC="en_US.UTF-8"
    export LC_TIME="en_US.UTF-8"
    export LC_COLLATE="en_US.UTF-8"
    export LC_MONETARY="en_US.UTF-8"
    export LC_MESSAGES="en_US.utf-8"
    export LC_PAPER="en_US.UTF-8"
    export LC_NAME="en_US.UTF-8"
    export LC_ADDRESS="en_US.UTF-8"
    export LC_TELEPHONE="en_US.UTF-8"
    export LC_MEASUREMENT="en_US.UTF-8"
    export LC_IDENTIFICATION="en_US.UTF-8"
    export LC_ALL=

#history
	HISTFILESIZE=50000
	HISTIGNORE=':cd:ls:cat'
	HISTCONTROL=erasedups
	HISTTIMEFORMAT='%F %T'

#alias
	alias ll='ls -l'
	#ask
	alias rm='rm -i'
	alias mv='mv -i'
    #alias cp='cp -i'
	alias c='clear'
    if [[ $DESKTOP_SESSION != '' ]]; then
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
    fi
	alias rejpg='for i in $(ls);do mv $i $i.jpg; done;'
	alias  r='reset'
	alias  e='exit'
	alias  es='emacs'
    alias e0='emacs --daemon'  #启动守护进程
    alias e1='emacsclient -t -a ""'  #在终端中开启emacs
    alias e2='emacsclient -c -a ""'  #启动emacs图形界面

	#file mssages
	alias lm='stat -c "%n %A %a"'
	alias MT='stat -c "%n %y"'
	alias AT='stat -c "%n %x"'
	alias CT='stat -c "%n %z"'
    #cd 
    # alias cdh='cd ~'
    # alias cd='pushd'
    # alias cdd='popd'
    # alias ccd='dirs -c'
    # alias '?'='dirs -v'
    . ~/.shell/z.sh
    #others
    alias _='sudo'
    alias v='vim'
   
    #go
    alias gob='go build'
    #quick run
    alias u='( urxvt & ) &>/dev/null && clear'
    #quick search
    alias hs='history | grep '
    alias pss='ps -ef | grep '


    if [[ $DESKTOP_SESSION != '' ]]; then
        alias hgb="hg branch | \
            tr -d '\n' | \
            xclip -selection clipboard && \
            echo \"$(xclip -selection clipboard -o)\" "
    fi

# Show all branches in a more readable way
alias hgbs="hg branches | \
            column -t | \
            sort"

# Same as hgbs, but additionally shows closed branches
alias hgbsc="hg branches -c | \
             column -t | \
             sort"

# Copy branch/changeset information to the clipboard.
# Useful when referring to commits
if [[ $DESKTOP_SESSION != '' ]]; then
    alias hglc="hg log -l 1 | \
        grep -1 changeset | \
        xclip -selection clipboard"
fi

hgd(){
    hg st $(hg root) | awk '{print $2}'  | xargs grep -Rn  "var_export\|var_dump\|console" | sed -n 's/:/ +/p'
}

# 
alias vps='ssh  -o ServerAliveInterval=60 root@36.54.4.47 -p 3843'
alias fdev='/usr/bin/firefox -no-remote -P dev'
alias edn='vim /home/h2ero/h2ero/dotfile/default.nginx'

cdpath=(. ~ ~/h2ero/www/)






CD_PATH_LIST="/home/h2ero/.cd_path_list"
function cdt {

echo $1
case $1 in
    "") 
        cd ~
        ;;
    +[1-9]|+[1-9][0-9]) 
        ;;
    *)  
        ;;
    esac
}
function cds {
# # show all record
# awk '{print NR" "$0}' file
# 
# # print path by line num
# sed -n 'p' file
# 
# # delete record
# sed '1d' file
# 
# #  j
    # grep -n "h*t" file
    awk '{print NR" "$0}' $CD_PATH_LIST
}
