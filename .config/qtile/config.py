# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
# Copyright (c) 2021 Paul Hoffmann
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


from abc import abstractclassmethod, abstractmethod
import os
import re
import socket
import subprocess
from typing import Iterable, MutableSequence, Sequence, Union
import libqtile
from libqtile.config import Drag, Key, ScratchPad, Screen, Group, Drag, Click, Rule, Match, EzKey, KeyChord
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer
from libqtile.hook import subscribe
from libqtile.backend.base import Window
from libqtile.core.manager import Qtile
from libqtile.log_utils import logger
from libqtile.utils import guess_terminal
os.system("export PATH=/home/phfn/.local/bin:$PATH")
from typing import List


#mod4 or mod = super key
super = "mod4"
alt = "mod1"
ctrl = "control"
shift = "shift"

home = os.path.expanduser('~')


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

@hook.subscribe.startup_once
def run_lock():
    path = "/home/phfn/.config/autostart.sh"
    if os.path.exists(path):
        subprocess.call([os.path.expanduser(path)])


     


keys = [

    Key([super, shift], "f", lazy.window.toggle_fullscreen()),
    Key([super], "q", lazy.window.kill()),
    Key([super, "control"], "r", lazy.restart()),

# Change group
    Key([super], "Tab", lazy.screen.toggle_group()),
    Key([alt], "Tab", lazy.screen.next_group()),
    Key([alt, "shift"], "Tab", lazy.screen.prev_group()),

# QTILE LAYOUT KEYS
    Key([super], "n", lazy.layout.normalize()),
    Key([super], "p", lazy.next_layout()),

# CHANGE FOCUS
    Key([super], "Up", lazy.layout.up()),
    Key([super], "Down", lazy.layout.down()),
    Key([super], "Left", lazy.layout.left()),
    Key([super], "Right", lazy.layout.right()),
    Key([super], "k", lazy.layout.up()),
    Key([super], "j", lazy.layout.down()),
    Key([super], "h", lazy.layout.left()),
    Key([super], "l", lazy.layout.right()),


# RESIZE UP, DOWN, LEFT, RIGHT
    Key([super, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([super, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([super, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([super, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([super, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([super, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([super, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    Key([super, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),



# FLIP LAYOUT FOR BSP
    Key([super, "mod1"], "k", lazy.layout.flip_up()),
    Key([super, "mod1"], "j", lazy.layout.flip_down()),
    Key([super, "mod1"], "l", lazy.layout.flip_right()),
    Key([super, "mod1"], "h", lazy.layout.flip_left()),

# MOVE WINDOWS UP OR DOWN BSP LAYOUT
    Key([super, "shift"], "k", lazy.layout.shuffle_up()),
    Key([super, "shift"], "j", lazy.layout.shuffle_down()),
    Key([super, "shift"], "h", lazy.layout.shuffle_left()),
    Key([super, "shift"], "l", lazy.layout.shuffle_right()),

# MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([super, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([super, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([super, "shift"], "Left", lazy.layout.swap_left()),
    Key([super, "shift"], "Right", lazy.layout.swap_right()),

# TOGGLE FLOATING LAYOUT
    Key([super, "shift"], "space", lazy.window.toggle_floating()),
    Key([super, "shift"], "x", lazy.shutdown()),

# MY SHIFT
    EzKey("M-<Return>", lazy.spawn("alacritty")),
    EzKey("A-<space>", lazy.spawn("rofi -show run")),
    EzKey("M-<space>", lazy.spawn("rofi -show drun")),
    EzKey("M-r", lazy.spawncmd()),
    EzKey("M-S-d", lazy.spawn("dmenu_run")),
    EzKey("M-f", lazy.spawn("firefox")),
    EzKey("M-e", lazy.spawn("thunar")),
    ]

groups = [
    Group(
        name="1",
        label="main"
    ),
    Group(
        name="2",
        label="web",
        spawn=["firefox"]
    ),
    Group(
        name="3",
        label="term"
    ),
    Group(
        name="4",
    ),
    Group(
        name="5"
    ),
    Group(
        name="6"
    ),
    Group(
        name="7",
        layout="max",
        label="vid",
        matches = [
            Match(
                wm_class=[
                    "Vlc",
                    "vlc",
                    "Mpv",
                    "mpv"
                    ]
                )
            ]
    ),
    Group(
        name="8",
        layout="max",
        label="mail",
        matches=[
            Match(
                wm_class=[
                    "mail",
                    "Mail",
                    "thunderbird",
                    "Thunderbird",
                    "ThunderBird"
                ]
            )
        ],
        spawn=["thunderbird"]
    ),
    Group(
        name="9",
        label="kp",
        matches=[
            Match(
                wm_class=[
                    "keepass",
                    "keepassxc",
                    "KeePass",
                    "KeePassXC",
                    ]
                )
            ],
        spawn=["keepassxc"]
    )
        ]

for i in groups:
    keys.extend([
        # CHANGE WORKSPACES
        Key([super], i.name, lazy.group[i.name].toscreen()),
        Key([super, ctrl, "shift"], i.name, lazy.window.togroup(i.name)),
        Key([super, "shift"], i.name, lazy.window.togroup(i.name) , lazy.group[i.name].toscreen()),
    ])

def init_layout_theme():
    return {"margin": 0,
            "border_width": 1,
            "border_focus": "#5e81ac",
            "border_normal": "#4c566a",
            "margin_on_single": 0
            }

layout_theme = init_layout_theme()


layouts = [
    layout.Bsp(**layout_theme, fair=False),
    layout.Matrix(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Max(**layout_theme)
]

# COLORS FOR THE BAR

colors = [
        ["#2F343F", "#2F343F"], # color 0
        ["#2F343F", "#2F343F"], # color 1
        ["#c0c5ce", "#c0c5ce"], # color 2
        ["#fba922", "#fba922"], # color 3
        ["#3384d0", "#3384d0"], # color 4
        ["#f3f4f5", "#f3f4f5"], # color 5
        ["#cd1f3f", "#cd1f3f"], # color 6
        ["#62FF00", "#62FF00"], # color 7
        ["#6790eb", "#6790eb"], # color 8
        ["#a9a9a9", "#a9a9a9"]  # color 9
        ]


# WIDGETS FOR THE BAR

widget_defaults = dict(
        font="Noto Sans",
        fontsize = 12,
        padding = 2,
        background=colors[1]
        )
thick = dict(
        linewidth = 1,
        padding = 10,
        foreground = colors[2],
        background = colors[1]
        )

def init_widgets_list():
    prompt = f"{os.environ['USER']}@{socket.gethostname()}"
    widgets_list = [
               widget.GroupBox(
                        # font="FontAwesome",
                        **widget_defaults | dict(
                        disable_drag = True,
                        active = colors[9],
                        inactive = colors[5],
                        highlight_method = "line",
                        this_current_screen_border = colors[8],
                        foreground = colors[2],
                        )),
               widget.Sep(**thick),
               widget.CurrentLayout(**widget_defaults),
               widget.Sep(**thick),
               widget.Prompt(),
               widget.WindowName(
                   **widget_defaults
                        ),
               widget.ThermalSensor(**widget_defaults |dict(
                        foreground_alert = colors[6],
                        padding = 3,
                        threshold = 80,
                        # fmt="{temperature:02d}"
                        )),
               widget.Sep(),
               widget.Battery(
                       format="{hour:d}:{min:02d}  {percent:2.0%}"
                       ),
               widget.BatteryIcon(
                   update_interval=1
                   ),
               widget.Sep(),
               # widget.TextBox(
               #          font="FontAwesome",
               #          text="  ",
               #          foreground=colors[3],
               #          fontsize=16
               #          ),
               widget.Volume(**widget_defaults | dict(
                        step=5
                   )),
               widget.Sep(),
               widget.Clock(**widget_defaults | dict(
                        format="%Y-%m-%d"
                        )),
               widget.Sep(),
               widget.Clock(**widget_defaults | dict(
                        format="%H:%M"
                        )),
               widget.Sep(),
               widget.Systray(
                        background=colors[1],
                        icon_size=20,
                        padding = 4
                        ),
              ]
    return widgets_list

widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2

screens =  [
            Screen(
                top=bar.Bar(
                    widgets=init_widgets_screen1(),
                    size=26,
                    opacity=0.8
                    ),
                    wallpaper="/home/phfn/Downloads/archbtw.png",
                    wallpaper_mode="fill"
                ),
            Screen(
                top=bar.Bar(
                    widgets=init_widgets_screen2(),
                    size=26,
                    opacity=0.8
                    ),
                    wallpaper = "/home/phfn/wallpapers/The_Witcher_Courtesan.jpg",
                    wallpaper_mode="fill"

                )
            ]


# MOUSE CONFIGURATION
mouse = [
    Drag([super], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([super], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []

main = None


@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True

floating_types = ["notification", "toolbar", "splash", "dialog"]


follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'Arcolinux-welcome-app.py'},
    {'wmclass': 'Arcolinux-tweak-tool.py'},
    {'wmclass': 'Arcolinux-calamares-tool.py'},
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},
    {'wmclass': 'makebranch'},
    {'wmclass': 'maketag'},
    {'wmclass': 'Arandr'},
    {'wmclass': 'feh'},
    {'wmclass': 'Galculator'},
    {'wmclass': 'arcolinux-logout'},
    {'wmclass': 'xfce4-terminal'},
    {'wname': 'branchdialog'},
    {'wname': 'Open File'},
    {'wname': 'pinentry'},
    {'wmclass': 'ssh-askpass'},

],  fullscreen_border_width = 0, border_width = 0)
auto_fullscreen = True

focus_on_window_activation = "focus" # or smart

wmname = "LG3D"



from trashbin import Trashbin

trash_group = ScratchPad("killPane")
groups.extend([trash_group])

trash = Trashbin(trash_group.name)

keys.extend([
    Key([super], "q", lazy.function(trash.append_currend_window)),
    Key([super, "shift"], "q", lazy.window.kill()),
    Key([super, "shift"], "e", lazy.function(trash.pop_to_current_group))
    ])

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
