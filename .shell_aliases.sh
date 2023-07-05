EDITOR=nvim
VISUAL=nvim
# source virtualenv
sv(){
	if [ -n "$1" ] && [ -z "$2" ]
	then
		source "$HOME/venvs/${1}/bin/activate"
	elif [ -n "$1" ] && [ -n "$2" ]
	then
		source "${2}/${1}/bin/activate"
	else
		if [ ! -e "venv/bin/activate" ]
		then
			python -m venv venv
		fi
		source "venv/bin/activate"
	fi
}
alias pir="pip install -r requirements.txt"
alias vs="deactivate"
alias g="git"
alias pacman="sudo pacman"
alias apt="sudo apt"
alias snvim="sudo -E nvim"
alias vi="nvim --noplugin"
alias v="nvim --clean"
alias dd="sudo dd status=progress"

open(){
	xdg-open $1 >/dev/null 2>&1
}
mdview(){
	if [ -n "$1" ]
	then
		retext --preview $1 >/dev/null 2>&1 &
	else
		retext --preview *.md >/dev/null 2>&1 &
	fi
}
ova2qcow2(){
	filename=$(echo $1 | cut -d'.' -f1)
	tar -xvf $filename.ova
	qemu-img convert -O qcow2 filename-disk001.vmdk filename.qcow2
}
alias ll="ls -lah"
alias webview="w3m -dump"
logcat(){
	adb logcat -d $1 | nvim -c 'set filetype=logcat'
}
android_screen_mirror(){
	adb exec-out screenrecord --output-format=h264 - | ffplay -framerate 60 -probesize 32 -sync video  -
}
android_screenshot(){
	adb exec-out screencap -p > $1
}
android_show_current_activity(){
	adb shell "dumpsys activity activities | grep mResumedActivity"
}
export PATH=$PATH:/home/phfn/.cargo/bin/
android_env(){
	export ANDROID_HOME=/home/phfn/Android/Sdk
	export ANDORID_SDK_ROOT=$ANDROID_HOME
	export JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
	PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin/:
	PATH=$PATH:$ANDROID_HOME/emulator/
	PATH=$PATH:$ANDROID_HOME/platform-tools/
}

