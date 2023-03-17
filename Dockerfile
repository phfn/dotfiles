from archlinux
run pacman --noconfirm -Syu git base-devel xorg-server python tree-sitter neovim
run useradd --create-home phfn
run echo "phfn ALL=(ALL:ALL) NOPASSWD:ALL">/etc/sudoers
user phfn
copy . /home/phfn/dotfiles
workdir /home/phfn/dotfiles
run /home/phfn/dotfiles/init.sh
run nvim --headless +q 2>/dev/null
run nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
run nvim --headless +q 2>/dev/null
run nvim --headless -c 'TSInstallSync all | q'
entrypoint bash -c "nvim"
