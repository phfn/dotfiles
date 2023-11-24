#/bin/python
from subprocess import call
import os

for file in os.listdir(os.path.expanduser("~/dotfiles/.config/")):
    if file.startswith("init") or file.startswith("."):
        continue
    command = f"ln -s ~/dotfiles/.config/{file} ~/.config/"
    print(command)
    os.system(command)
    # call(command.split(" "))

