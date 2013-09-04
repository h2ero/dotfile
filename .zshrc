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
export PATH=$PATH:/home/h2ero/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$GOPATH/bin:/home/h2ero/bin/bin


################################################################
#
#
#
#
#
################################################################

    set -o vi
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
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
	alias rejpg='for i in $(ls);do mv $i $i.jpg; done;'
	alias  r='reset'
	alias  e='exit'
	#file mssages
	alias lm='stat -c "%n %A %a"'
	alias MT='stat -c "%n %y"'
	alias AT='stat -c "%n %x"'
	alias CT='stat -c "%n %z"'
    #cd 
    alias cdh='cd ~'
    alias cd='pushd'
    alias cdd='popd'
    alias ccd='dirs -c'
    alias '?'='dirs -v'
    #others
    alias _='sudo'


alias hgb="hg branch | \
           tr -d '\n' | \
           xclip -selection clipboard && \
           echo \"$(xclip -selection clipboard -o)\" "

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
alias hglc="hg log -l 1 | \
            grep -1 changeset | \
            xclip -selection clipboard"

hgd(){
    hg st $(hg root) | awk '{print $2}'  | xargs grep -Rn  "var_export\|var_dump\|console"
}

# 
alias vps='ssh  -o ServerAliveInterval=60 root@36.54.4.47 -p 3843'
alias s2='cd /home/h2ero/h2ero/www/sysvisual2'
alias dbtm='mysql -h 192.168.9.2 -P 9001 -udev -p'
alias fdev='/usr/bin/firefox -no-remote -P dev'
alias edn='vim /home/h2ero/h2ero/dotfile/default.nginx'

cdpath=(. ~ ~/h2ero/www/)
