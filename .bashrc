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
