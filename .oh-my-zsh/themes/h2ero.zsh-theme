#local IP=$(wget -qO -  )
local INNER_IP=$(ifconfig | sed -n  /Bcast/p | awk -F : '{ sub("  Bcast","", $2); print $2 }')
local UPTIME=$(uptime | awk 'sub(",","",$3){print $3}')
# local WH=$(wget -qO - http://www.weather.com.cn/data/sk/101270101.html | sed -n 's/.*temp":"\([0-9]\+\)".*/\1/p')

PROMPT=$'
%{$fg[blue]%}%/%{$reset_color%} ⚡ %{$fg[green]%}$(vcprompt -f "["%s)$(vcprompt -f "\:"%b" ")%{$fg[red]%}$(vcprompt -f %m)%{$fg[green]%}$(vcprompt -f "] ")$(bzr_prompt_info)%{$fg[white]%}[%n@%m]%{$reset_color%} %{$fg[white]%}[%T]%{$reset_color%}   <${INNER_IP}> %{$fg[red]%}${UPTIME}
%{$fg_bold[black]%}>⚡%{$reset_color%}'

PROMPT2="%{$fg_blod[black]%}%_>  %{$reset_color%}"

GIT_CB="git::"
ZSH_THEME_SCM_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX$GIT_CB
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

## Bazaar integration
bzr_prompt_info() {
	BZR_CB=`bzr nick 2> /dev/null | grep -v "ERROR" | cut -d ":" -f2 | awk -F / '{print "bzr::"$1}'`
	if [ -n "$BZR_CB" ]; then
		BZR_DIRTY=""
		[[ -n `bzr status` ]] && BZR_DIRTY="%{$fg[red]%} *%{$reset_color%}"
		echo "$ZSH_THEME_SCM_PROMPT_PREFIX$BZR_CB$BZR_DIRTY$ZSH_THEME_GIT_PROMPT_SUFFIX"
	fi
}
