# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="h2ero"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export GOPATH='/home/h2ero/h2ero/code/mygo/'
export PATH=$PATH:/home/h2ero/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$GOPATH/bin:/home/h2ero/bin/bin:$GOPATH/bin:/home/h2ero/bin/go/bin

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
alias phpd='php -d xdebug.profiler_enable=On '
alias s='sudo'
alias s='sudo service '

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


hgd(){
    hg st $(hg root) | grep -v "?" | awk '{print $2}'  | xargs grep -Rn  "var_export\|var_dump\|console" | sed -n 's/:/ +/p'
}

hgl(){
    hg st $(hg root)| grep -v "?" | awk '{print $2}' | xargs -I {} php -l {} 
}

#
alias vps='ssh  -o ServerAliveInterval=60 root@36.54.4.47 -p 3843'
alias fdev='/usr/bin/firefox -no-remote -P dev'
alias edn='vim /home/h2ero/h2ero/dotfile/default.nginx'

cdpath=(. ~ ~/h2ero/www/)

eval $(dbus-launch --sh-syntax)
export $(dbus-launch)
