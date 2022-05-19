#gitignore
if [[ -f ~/.gitignore ]];then
	echo "do not connect .gitignore, becouse already exist"
	echo "ln -s /home/phfn/dotfiles/git/.gitignore ~/.gitignore"
else
	ln -s /home/phfn/dotfiles/git/.gitignore ~/.gitignore
fi

#gitconfig
touch ~/.inittmp

if [[ -f ~/.gitconfig ]];then
	cat ~/.gitconfig > ~/.inittmp
fi

echo "[include]
	path = ~/dotfiles/git/.gitconfig" > ~/.gitconfig
cat ~/.inittmp >> ~/.gitconfig

rm ~/.inittmp
