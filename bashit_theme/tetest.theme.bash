# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.

SCM_THEME_PROMPT_DIRTY=" ${red?}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
SCM_THEME_PROMPT_PREFIX=" ${green?}|"
SCM_THEME_PROMPT_SUFFIX="${green?}|"

GIT_THEME_PROMPT_DIRTY=" ${red?}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
GIT_THEME_PROMPT_PREFIX=" ${green?}|"
GIT_THEME_PROMPT_SUFFIX="${green?}|"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"

function __username_color() {
    local ucolor=${cyan?}
	# Detect root shell
	if [ "$(whoami)" = root ]; then
		ucolor=${bold_red?}
	fi

	printf "${ucolor}"
}

function prompt_command() {
    local ps1_raw
    ps1_raw="$(__username_color)\u ${yellow?}at ${blue?}\h "
	ps1_raw+="${reset_color?}in "
	ps1_raw+="$(__username_color)\w "

    ps1_raw=${ps1_raw@P}
    ps1_raw=${ps1_raw//[$'\001'$'\002']}
    ps1_raw=$(printf "%*s\r%s" "$(tput cols)" "$(date +"%H:%M:%S")" "${ps1_raw}")
	PS1="\n${ps1_raw}"
    PS1+="\n${bold_purple?}$(scm_prompt_char_info) "
	PS1+="${green?}→${reset_color?} "
}

safe_append_prompt_command prompt_command
