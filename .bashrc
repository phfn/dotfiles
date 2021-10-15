EDITOR=nvim
VISUAL=nvim
set -o vi
# source virtualenv
sv(){
	if [ -n "$1" ] && [ -z "$2" ]
	then
		source "$HOME/venvs/${1}/bin/activate"
	elif [ -n "$1" ] && [ -n "$2" ]
	then
		source "${2}/${1}/bin/activate"
	else
		source "venv/bin/activate"
	fi
}
alias vs="deactivate"
alias g="git"
alias pacman="sudo pacman"
alias apt="sudo apt"
alias snvim="sudo -E nvim"

mdview(){
	if [ -n "$1" ]
	then
		retext --preview $1 >/dev/null 2>&1 &
	else
		retext --preview *.md >/dev/null 2>&1 &
	fi
}
alias ll="ls -la"
