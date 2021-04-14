function update_current_git_vars {
	unset __CURRENT_GIT_BRANCH
	unset __CURRENT_GIT_BRANCH_STATUS
	unset __CURRENT_GIT_BRANCH_IS_DIRTY

	local st="$(git status 2>/dev/null)"
	if [[ -n "$st" ]]; then
	    local -a arr
	    arr=(${(f)st})

	    if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
		__CURRENT_GIT_BRANCH='no-branch'
	    else
		__CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
	    fi

	    if [[ $arr[2] =~ 'Your branch is' ]]; then
		if [[ $arr[2] =~ 'ahead' ]]; then
		    __CURRENT_GIT_BRANCH_STATUS='ahead'
		elif [[ $arr[2] =~ 'diverged' ]]; then
		    __CURRENT_GIT_BRANCH_STATUS='diverged'
		else
		    __CURRENT_GIT_BRANCH_STATUS='behind'
		fi
	    fi

	    if [[ ! $st =~ 'nothing to commit' ]]; then
		__CURRENT_GIT_BRANCH_IS_DIRTY='1'
	    fi
	fi
}

function prompt_git_info {
	if [ -n "$__CURRENT_GIT_BRANCH" ]; then
	    local s="("
	    s+="$__CURRENT_GIT_BRANCH"
	    case "$__CURRENT_GIT_BRANCH_STATUS" in
		ahead)
		s+="↑"
		;;
		diverged)
		s+="↕"
		;;
		behind)
		s+="↓"
		;;
	    esac
	    if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
		s+="⚡"
	    fi
	    s+=")"
	 
	    printf " %s%s" "%{${fg[yellow]}%}" $s
	fi
}

function chpwd_update_git_vars {
	update_current_git_vars
}

function preexec_update_git_vars {
	case "$1" in 
	    git*)
	    __EXECUTED_GIT_COMMAND=1
	    ;;
	esac
}

function precmd_update_git_vars {
	if [ -n "$__EXECUTED_GIT_COMMAND" ]; then
	    update_current_git_vars
	    unset __EXECUTED_GIT_COMMAND
	fi
}

# Initialize colors.
autoload -U colors
colors
 
# Allow for functions in the prompt.
setopt PROMPT_SUBST

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
 
# Set the prompt.
PROMPT=$'%{${fg[cyan]}%}%B%~%b$(prompt_git_info)%{${fg[default]}%} '