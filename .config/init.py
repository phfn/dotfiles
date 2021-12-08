#/bin/python
from subprocess import call
import os

for file in os.listdir("/home/phfn/dotfiles/.config/"):
    if file.startswith("init") or file.startswith("."):
        continue
    command = f"ln -s /home/phfn/dotfiles/.config/{file} /home/phfn/.config/"
    print(command)
    os.system(command)
    # call(command.split(" "))

