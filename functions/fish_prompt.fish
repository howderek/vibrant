set __fish_git_prompt_color_branch blue

set __fish_git_prompt_char_upstream_prefix ' '
set __fish_git_prompt_char_stateseparator ' '

set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_color_upstream_ahead yellow
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_color_upstream_behind yellow
set __fish_git_prompt_char_upstream_behind '↓'


set __fish_git_prompt_showuntrackedfiles true
set __fish_git_prompt_color_untrackedfiles red
set __fish_git_prompt_char_untrackedfiles '+'

set __fish_git_prompt_showdirtystate true
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_char_dirtystate '*'

set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_char_stagedstate '+'

set __fish_git_prompt_color_cleanstate green
set __fish_git_prompt_char_cleanstate '='



set _vbr_cyan    (set_color cyan)
set _vbr_yellow  (set_color yellow)
set _vbr_red     (set_color red)
set _vbr_blue    (set_color blue)
set _vbr_green   (set_color green)
set _vbr_gray    (set_color 999)



# [user@host] path [branch [git status]] prompt
function fish_prompt
	set -l exit_code $status

	set -l prompt ''
	set -e prompt[1]

	# display username and hostname if logged in as root, in sudo or ssh session
	if [ \( (id -u) -eq 0 -o $SUDO_USER \) -o $SSH_CONNECTION ]
		set -l host (hostname | cut -f 1 -d '.')
		set prompt $prompt $_vbr_yellow$USER$_vbr_gray'@'$_vbr_cyan$host
	end

	# Git
	set prompt $prompt (__fish_git_prompt '%s')

	# prompt symbol
	if [ $exit_code != 0 ]; set prompt $prompt $_vbr_red'λ'
	else;                   set prompt $prompt $_vbr_green'λ'
	end

	echo -n $prompt (set_color normal)
end

function fish_right_prompt
	# path
	set -l prompt ''
	set -e prompt[1]
	set prompt $prompt $_vbr_gray(pwd | sed "s:^$HOME:~:")(set_color normal)
	echo -n $prompt
end
