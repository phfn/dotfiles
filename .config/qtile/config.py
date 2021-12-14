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


import os
import re
import socket
import subprocess
from random import shuffle
from libqtile.config import Drag, Key, ScratchPad, Screen, Group, Drag, Click, Rule, Match, EzKey, KeyChord
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook
from libqtile.core.manager import Qtile

# mod4 or mod = super key
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
def start_xdg():
    blacklist = [
            "pamac-tray.desktop",
            "pamac-tray-budgie.desktop",
            "xfce4-notes-autostart.desktop",
            # "autorandr.desktop",
            ]
    autostart_path = "/etc/xdg/autostart"
    for file in os.listdir(autostart_path):
        if file in blacklist:
            continue
        os.system(f"dex {autostart_path}/{file}")



def get_random_wallpaper():
    # Pick first location and the first files in there
    backgroud_locations = [
        "/home/backgrounds/",
        "/usr/share/backgrounds/manjaro-wallpapers-18.0",
        "/usr/share/backgrounds/",
    ]

    for backgroud_location in backgroud_locations:
        try:
            wallpapers = [
                    os.path.join(backgroud_location, file)
                    for file
                    in os.listdir(backgroud_location)
                    ]
            if not wallpapers:
                raise FileNotFoundError
            break
        except FileNotFoundError:
            pass
    shuffle(wallpapers)
    return wallpapers[0]


@hook.subscribe.startup
def start_autostart_script():
    path = "/home/phfn/.config/autostart.sh"
    if os.path.exists(path):
        subprocess.call([os.path.expanduser(path)])
        os.system(
                os.path.expanduser(path)
                + " > /home/phfn/.config/autostart.log")


@lazy.function
def spawn_chat_privat(qtile: Qtile):
    qtile.cmd_spawn("signal-desktop", shell=True)
    qtile.cmd_spawn("flatpak run com.discordapp.Discord", shell=True)


@lazy.function
def spawn_chat_work(qtile: Qtile):
    qtile.cmd_spawn("mattermost-desktop", shell=True)
    qtile.cmd_spawn("teams", shell=True)


keys = [

    Key([super, shift], "f", lazy.window.toggle_fullscreen()),
    Key([super], "q", lazy.window.kill()),
    Key([super, "control"], "r", lazy.restart()),

    # Change group
    Key([super], "Tab", lazy.screen.toggle_group()),
    Key([alt], "Tab", lazy.group.next_window()),
    Key([alt, "shift"], "Tab", lazy.group.prev_window()),
    Key([super, alt], "Tab", lazy.screen.next_group()),

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
    EzKey("A-<space>", lazy.spawn("rofi -show drun -show-icons -sorting-method fzf")),
    EzKey("A-S-<space>", lazy.spawn("rofi -show run")),
    EzKey("M-w", lazy.spawn("rofi -show window -show-icons -sorting-method fzf")),
    EzKey("M-S-s", lazy.spawn("rofi -show ssh")),


    EzKey("M-A-l", lazy.spawn("xflock4")),
    EzKey("M-r", lazy.spawncmd()),
    EzKey("M-S-d", lazy.spawn("dmenu_run")),
    EzKey("M-p", lazy.spawn("autorandr-rofi")),
    EzKey("M-A-f", lazy.spawn("firefox -p privat")),
    EzKey("M-e", lazy.spawn("thunar")),
    EzKey("M-S-k", lazy.spawn("keepmenu")),
    EzKey("M-<space>", lazy.spawn("switch_layout")),
    EzKey("M-x", lazy.spawn("arcolinux-logout")),
    EzKey("M-S-s", lazy.spawn("xfce4-screenshooter -r -c")),
    EzKey("M-<period>", lazy.spawn("rofimoji")),
    KeyChord([super], "s",
        [
            Key([], "f", lazy.spawn("firefox")),
            Key([shift], "f", lazy.spawn("firefox -P privat")),
            Key([], "a", lazy.spawn("alacritty")),
            Key([], "x", lazy.spawn("xterm")),
            Key([], "b", lazy.spawn("blueman-manager")),
            Key([], "p", lazy.spawn("pamac-manager")),
            Key([], "c", spawn_chat_work),
            Key([shift], "c", spawn_chat_privat),
        ]
    ),


    # Music
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    # Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -D pulse set Master 1+ on && amixer set Master 10%+")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 10%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 10%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -D pulse set Master 1+ toggle")),
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
        name="6",
        label="chat",
        matches=[
            Match(
                wm_class=[
                    "teams",
                    "teams-for-linux"
                    "mattermost-desktop",
                    "mattermost",
                    "matterhorn",
                    "signal"
                    ]
                ),
            Match(title="matterhorn")
            ],
    ),
    Group(
        name="7",
        layout="max",
        label="vid",
        matches=[
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
        label="mail",
        matches=[
            Match(
                wm_class=[
                    "mail",
                    "Mail",
                    "thunderbird",
                    "Thunderbird",
                    "ThunderBird",
                    "evolution",
                    "Evolution"
                ]
            )
        ],
        # spawn=["evolution"]
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
    ),
        ]

for group in groups:
    keys.extend([
        # CHANGE WORKSPACES
        Key([super], group.name, lazy.group[group.name].toscreen()),
        Key([super, ctrl, "shift"], group.name, lazy.window.togroup(group.name)),
        Key([super, "shift"], group.name, lazy.window.togroup(group.name) , lazy.group[group.name].toscreen()),
    ])

groups.extend([
    Group(
            name="nextcloud",
            label="",
            spawn="nextcloud"
            )
    ])


def init_layout_theme():
    return {"margin": 0,
            "border_width": 3,
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
        ["#2F343F", "#2F343F"],  # color 0
        ["#2F343F", "#2F343F"],  # color 1
        ["#c0c5ce", "#c0c5ce"],  # color 2
        ["#fba922", "#fba922"],  # color 3
        ["#3384d0", "#3384d0"],  # color 4
        ["#f3f4f5", "#f3f4f5"],  # color 5
        ["#cd1f3f", "#cd1f3f"],  # color 6
        ["#62FF00", "#62FF00"],  # color 7
        ["#6790eb", "#6790eb"],  # color 8
        ["#a9a9a9", "#a9a9a9"]  # color 9
        ]


# WIDGETS FOR THE BAR

widget_defaults = dict(
        font="Noto Sans",
        fontsize=12,
        padding=2,
        background=colors[1]
        )
thick = dict(
        linewidth=1,
        padding=10,
        foreground=colors[2],
        background=colors[1]
        )

def init_widgets_list():
    prompt = f"{os.environ['USER']}@{socket.gethostname()}"
    widgets_list = [
               widget.GroupBox(
                   # font="FontAwesome",
                   **widget_defaults | dict(
                       disable_drag=True,
                       active=colors[9],
                       inactive=colors[5],
                       highlight_method="line",
                       this_current_screen_border=colors[8],
                       foreground=colors[2],
                        )),
               widget.Sep(**thick),
               widget.CurrentLayout(**widget_defaults),
               widget.Sep(**thick),
               widget.Prompt(),
               widget.WindowName(
                   **widget_defaults
                        ),
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
                        format="%H:%M"
                        )),
               widget.Sep(),
               widget.Clock(**widget_defaults | dict(
                        # format="%Y-%m-%d"
                        format="%d.%m.%Y"
                        )),
              ]
    return widgets_list


widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    widgets_screen1.extend([
        widget.Sep(),
        widget.Systray(
            background=colors[1],
            icon_size=20,
            padding=4
            )
    ])
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2


screens = [
            Screen(
                top=bar.Bar(
                        widgets=init_widgets_screen1(),
                        size=26,
                        opacity=0.8
                    ),
                wallpaper="/usr/share/backgrounds/illyria-default-lockscreen.jpg",
                wallpaper_mode="fill"
                ),
            Screen(
                top=bar.Bar(
                        widgets=init_widgets_screen2(),
                        size=26,
                        opacity=0.8
                    ),
                wallpaper="/usr/share/backgrounds/manjaro-wallpapers-18.0/manjaro_maia_logo.jpg",
                wallpaper_mode="fill"

                )
            ]


@hook.subscribe.startup_complete
def repaint_screens(*args):
    subprocess.call(
            ["feh", "--bg-fill", screens[0].wallpaper, "--bg-fill", screens[1].wallpaper]
    )


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
    {'wmclass': 'zoom', 'wname': 'chat'},

],  fullscreen_border_width=0, border_width=0)
# auto_fullscreen = True
auto_fullscreen = False

focus_on_window_activation = "smart"  # or smart

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

def set_browser(browser: str):
    subprocess.run(
            f"xdg-mime default {browser} x-scheme-handler/http",
            shell=True,
        )
    subprocess.run(
            f"xdg-mime default {browser} x-scheme-handler/https",
            shell=True,
        )

from qtile_profiles import Profile, ProfileManager

work = Profile(
        programs={
            "firefox": "firefox",
            "thunderbird": "flatpak run org.mozilla.Thunderbird",
            "teams": "chromium --app=https://teams.office.com",
            },
        init=[
            ("web", ["firefox"]),
            ("chat", ["mattermost-desktop", "teams"]),
            ("mail", ["tunderbird"]),
            ("kp", ["keepassxc"]),
            ],
        on_load=lambda qtile: set_browser("firefox.desktop")
        )
privat = Profile(
        programs={
            "firefox": "firefox -P privat",
            "thunderbird": "thunderbird",
            "discord": "discord",
            },
        init=[
            ("web", ["firefox"]),
            ("chat", ["signal-desktop", "discord"]),
            ("mail", ["thunderbird"]),
            ("kp", ["keepassxc"]),
            ],
        on_load=lambda qtile: set_browser("firefox-privat.desktop")
        )

profiles = ProfileManager([work, privat])

keys.extend([
    Key([super, shift], "p", lazy.function(profiles.next_profile)),
    Key([super], "f", lazy.function(profiles.spawn, "firefox")),
    Key([super], "i", lazy.function(profiles.current_profile.spawn_init)),
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
    Match(title=re.compile('Android Emulator*')),
])
