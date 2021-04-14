if [ -n "${ZSH_VERSION}" ]; then

	# =============
	# = FUNCTIONS =
	# =============
	# shellcheck disable=SC1091
	. "$zsh_themes_dir"/oh-my-git/base.sh

	# ===================
	# = PROMPT SEGMENTS =
	# ===================
	NEWLINE=$'\n'
	SEPARATOR=$'\ue0b0'
	PS1_SEGMENT_ONE="%K{214}%F{232}%B%(!.[🤖 %n].[🧑‍💻 %n]) %~%b%f%k"
	PS1_SEGMENT_TWO="%K{31}%F{214}$SEPARATOR%f " 
	PS1_SEGMENT_THREE="%(?.✅.❌ exit code:%F{red}%?%f) ⌨️ %F{048} >>%f "

	# ==================
	# = PROMPT DEFAULT =
	# ==================
	omg_ungit_prompt="$PS1_SEGMENT_ONE$PS1_SEGMENT_TWO%k${NEWLINE}$PS1_SEGMENT_THREE"
	
	# ====================
	# = GIT STATUS ICONS =
	# ====================
	omg_is_a_git_repo_symbol=$'%F{202}[\ue702]%f'
	omg_just_init_symbol='🎉'
	omg_has_untracked_files_symbol=' 🦠 '
	omg_has_adds_symbol=' ✅ '
	omg_has_deletions_symbol='🔥 '
	omg_has_cached_deletions_symbol=' 🗑 '
	omg_has_modifications_symbol=' ✏️ '
	omg_has_cached_modifications_symbol=' 🗃 '
	omg_ready_to_commit_symbol=' 📡 '
	omg_is_on_a_tag_symbol=' 🏷 '
	omg_needs_to_merge_symbol=' 🧬 '
	omg_detached_symbol=' 🚨 '
	omg_can_fast_forward_symbol=' 🚀 '
	omg_has_diverged_symbol=' 🔀 '
	omg_not_tracked_branch_symbol=' 📴 '
	omg_rebase_tracking_branch_symbol=' ♻️ '
	omg_merge_tracking_branch_symbol=' 🔂 '
	omg_should_push_symbol=' 🆙 '
	omg_has_stashes_symbol=' ⭐️ '
	omg_has_action_in_progress_symbol=' 🚧'
	omg_current_branch_symbol='🪵 '

	 enrich_append() 
	 {
		local flag=$1
		local symbol=$2
		if [[ $flag == false ]]; then symbol=''; fi
			echo -n "${symbol}"
	}

	custom_build_prompt() 
	{
			local enabled=${1}
			local current_commit_hash=${2}
			local is_a_git_repo=${3}
			local current_branch=$4
			local detached=${5}
			local just_init=${6}
			local has_upstream=${7}
			local has_modifications=${8}
			local has_modifications_cached=${9}
			local has_adds=${10}
			local has_deletions=${11}
			local has_deletions_cached=${12}
			local has_untracked_files=${13}
			local ready_to_commit=${14}
			local tag_at_current_commit=${15}
			local is_on_a_tag=${16}
			local has_upstream=${17}
			local commits_ahead=${18}
			local commits_behind=${19}
			local has_diverged=${20}
			local should_push=${21}
			local will_rebase=${22}
			local has_stashes=${23}
			local has_actions=${24}

			if [[ $is_a_git_repo == true ]]; then
				# main prompt
				prompt="$PS1_SEGMENT_ONE$PS1_SEGMENT_TWO"
				
				# git repo
				prompt+=$(enrich_append "$is_a_git_repo" "$omg_is_a_git_repo_symbol")
				
				# if actions required
				prompt+=$(enrich_append "$has_actions" "$omg_has_action_in_progress_symbol")
				
				# on filesystem
				prompt+=$(enrich_append "$just_init" "$omg_just_init_symbol")
				prompt+=$(enrich_append "$has_stashes" "$omg_has_stashes_symbol")
				prompt+=$(enrich_append "$has_untracked_files" "$omg_has_untracked_files_symbol")
				prompt+=$(enrich_append "$has_modifications" "$omg_has_modifications_symbol")
				prompt+=$(enrich_append "$has_deletions" "$omg_has_deletions_symbol")

				# ready
				prompt+=$(enrich_append "$has_adds" "$omg_has_adds_symbol")
				prompt+=$(enrich_append "$has_modifications_cached" "$omg_has_cached_modifications_symbol")
				prompt+=$(enrich_append "$has_deletions_cached" "$omg_has_cached_deletions_symbol")

				# next operation
				prompt+=$(enrich_append "$ready_to_commit" "$omg_ready_to_commit_symbol")

				# where
				prompt="${prompt}%B%F{white}"

				if [[ $detached == true ]]; then
					prompt+=$(enrich_append "$detached" "$omg_detached_symbol")
					prompt+=$(enrich_append "$detached" "[${current_commit_hash:0:7}]")
				else
					if [[ $has_upstream == false ]]; then
						prompt+=$(enrich_append true " -- ${omg_not_tracked_branch_symbol}  --  [${omg_current_branch_symbol}${current_branch}]")
					else
						if [[ $will_rebase == true ]]; then
							local type_of_upstream=$omg_rebase_tracking_branch_symbol
						else
							local type_of_upstream=$omg_merge_tracking_branch_symbol
						fi

						if [[ $has_diverged == true ]]; then
							prompt+=$(enrich_append true "-${commits_behind} ${omg_has_diverged_symbol} +${commits_ahead}")
						else
							if [[ $commits_behind -gt 0 ]]; then
								prompt+=$(enrich_append true "-${commits_behind} ${omg_can_fast_forward_symbol} --")
							fi
							if [[ $commits_ahead -gt 0 ]]; then
								prompt+=$(enrich_append true "-- ${omg_should_push_symbol} +${commits_ahead} ")
							fi
							if [[ $commits_ahead == 0 && $commits_behind == 0 ]]; then
								prompt+=$(enrich_append true " --   -- ")
							fi
						fi
						prompt+=$(enrich_append true "[${omg_current_branch_symbol}${current_branch}${type_of_upstream}${upstream//\/$current_branch/}]  ")
					fi
				fi
				prompt+=$(enrich_append "${is_on_a_tag}" "${omg_is_on_a_tag_symbol} ${tag_at_current_commit}")
				prompt+="%f%b%k${NEWLINE}"
				prompt+="$PS1_SEGMENT_THREE"
			else
				prompt=$omg_ungit_prompt
			fi
			echo "${prompt}"
		}

		# Allow functions in the prompt.
		setopt prompt_subst

		# Set the prompt
		PS1='$(build_prompt)%f'

		# Set the prompt right
		RPROMPT='%f%D %*⌚️'

fi
