autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
setopt prompt_subst

# prompt agnoster prototype
NEWLINE=$'\n'
SEPARATOR=$'\ue0b0'
PS1_SEGMENT_ONE="%K{214}%F{232}%B%(!.[🤖 %n].[🧑‍💻 %n]) %~%b%f%k"
PS1_SEGMENT_TWO="%K{31}%F{214}$SEPARATOR%f %F{231}${vcs_info_msg_0_}%f %k" 
PS1_SEGMENT_THREE="%(?.✅.❌ exit code:%F{red}%?%f) ⌨️ %F{048} >>%f "

PS1='$PS1_SEGMENT_ONE$PS1_SEGMENT_TWO${NEWLINE}$PS1_SEGMENT_THREE'
RPS1="⌚️ %D %*" 

# GIT PROMPT CONFIG
### set the format for $vcs_info_msg_0 strings
### %s: vcs service (in our case 'git')
### %r: repository name
### %b: branch name
### %u: 'U' if there are unstaged files
### %c: 'S' if there are staged, but uncommitted files
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' stagedstr '✚'
zstyle ':vcs_info:*' unstagedstr '±'
zstyle ':vcs_info:git:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:git:*' formats '%F{231}[🪵 %b] %r%f%u%c'
zstyle ':vcs_info:*' enable git

autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_vcs_info