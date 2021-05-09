EDITOR=nvim
VISUAL=nvim
set -o vi
# source virtualenv
sv(){
	source "${1:-"venv"}/bin/activate"
}
