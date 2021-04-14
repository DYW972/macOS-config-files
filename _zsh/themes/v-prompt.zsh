# =================
# = THE V THEME 🖖 =
# =================
# The V Prompt or The 🖖 prompt 
# A theme inspired by :
# apple and agnoster theme form OMZ
# Oh My Git
# Armin Briegel
# Damso
#

# %(?.√.?%?)  :  if return code `?` is 0, show `√`, else show `?%?`
# %?          :  exit code of previous command
# %1~         :  current working dir, shortening home to `~`, show the last `1` element
# %#          :  `#` if root, `%` otherwise
# %B %b       :  start/stop bold
# %F{...}     :  colors, see https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
# %f          :  reset to default color
# %(!.        :  conditional depending on privileged user

# PROMPT='%(?.√.%F{red}?%? )%B%F{240}%2~%b%f %(?.%F{green}.%F{red})%(!.#.🖖 ➜)%f '

# =============
# = VARIABLES =
# =============

# APPLE_ICON="\uf302" # ''
# LINUX_ICON="\uf17c" # '🐧'
# LAPTOP_ICON="\uf823" # '💻'
#
# GIT_ICON="\ue702"
# ROOT_ICON="\Uf52a" # '⚡'
# ERROR_ICON="\ufc65" # '\uf00d'
# BACKGROUND_JOBS_ICON='\uf085' #⚙
# SEGMENT_SEPARATOR=$'\ue0b0' # 
#
# CURRENT_OS=$(uname -s)
# CURRENT_BG='NONE'
# CURRENT_THEME=$(osascript -e 'tell application "Terminal" to return name of current settings of first window')
#
# # =============
# # = FUNCTIONS =
# # =============
#
# get-current-os() {
# 	# Get the current operating system to display a representing icon.
# 	case $CURRENT_OS in "Darwin") echo -n $APPLE_ICON;;
# 	"Linux") echo -n $LINUX_ICON;;
# 	*) echo -n $LAPTOP_ICON;;
# 	esac
# }
#
# # Get the current theme and set the current foreground to the specific color.
# case $CURRENT_THEME in "Solarized Light") CURRENT_FG='black';;
# 	"Solarized Dark") CURRENT_FG='white';;
# 	*) CURRENT_FG='black';;
# esac
