import os
import subprocess
import psutil
from libqtile import qtile
from libqtile import bar, layout, widget,hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
modkey = "mod5"
modfloat= "mod1"
myTerm = "kitty"
myTerm2 = "alacritty"
myBrowser = "./programs/firefox/firefox"
code = "subl"
rofi = "rofi -show drun"
window= "rofi -show window"
pavu = "pavucontrol"

color = {
    'background': '#282a37',
    'foreground': '#f8f8f2',
    'floating': '#8be9fd',
}

keys = [
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    #Columns
    Key([mod, "control"], "h", lazy.layout.shuffle_left()),
    Key([mod, "control"], "l", lazy.layout.shuffle_right()),
    Key([mod, "control"], "j", lazy.layout.shuffle_down()),
    Key([mod, "control"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.grow_left()),
    Key([mod, "shift"], "l", lazy.layout.grow_right()),
    Key([mod, "shift"], "j", lazy.layout.grow_down()),
    Key([mod, "shift"], "k", lazy.layout.grow_up()),
    Key([mod], "n", lazy.layout.normalize()),
    # MonadTall
    Key([modkey, "shift"], "h", lazy.layout.swap_left()),
    Key([modkey, "shift"], "l", lazy.layout.swap_right()),
    Key([modkey, "shift"], "j", lazy.layout.shuffle_down()),
    Key([modkey, "shift"], "k", lazy.layout.shuffle_up()),
    Key([modkey], "u", lazy.layout.grow()),
    Key([modkey], "i", lazy.layout.shrink()),
    Key([modkey], "o", lazy.layout.maximize()),
    Key([modkey, "shift"], "space", lazy.layout.flip()),

    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod, "control"], "space", lazy.window.toggle_floating()),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.reload_config()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod, "shift"], "r", lazy.spawncmd()),

    # Run Programs
    Key([mod], "Return", lazy.spawn(myTerm)),
    Key([mod], "o", lazy.spawn(myTerm2)),
    Key([mod], "b", lazy.spawn(myBrowser)),
    Key([mod], "s", lazy.spawn(code)),
    Key([mod], "r", lazy.spawn(rofi)),
    Key([mod], "p", lazy.spawn(window)),
]

groups = [
        Group('1', label="", matches=[Match(wm_class=["firefox"])], layout="columns"),
        Group('2', label="", layout="columns"),
        Group('3', label="", matches=[Match(wm_class=["Sublime_text","Code"])], layout="columns"),
        Group('4', label=""),
        Group('5', label="", matches=[Match(wm_class=["TelegramDesktop"])], layout="columns"),
        Group('6', label=""),
        Group('7', label=""),
        Group('8', label="", matches=[Match(wm_class=[""])], layout="floating"),
        # Group('9', label="", matches=[Match(wm_class=[""])], layout="floating"),
        ]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
                ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.Columns(border_focus="f6e71d",border_focus_stack="f6e71d", border_width=3, margin=8),
    layout.MonadTall(border_focus="f6e71d",border_width=3, margin=7),
    layout.Floating(),
    layout.Max(),

]

mouse = [
    Drag([modfloat], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([modfloat], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([modfloat], "Button2", lazy.window.bring_to_front()),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=6,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(filename='~/.config/qtile/images/logo-dark.png',background='b98ef7', scale = "False",margin=3, mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(rofi)}),
                # widget.Spacer(length=10, background=None),
                widget.Prompt(prompt='Run: '),
                widget.GroupBox(highlight_method='text', active='8d99bf', inactive='44475a',this_current_screen_border='f5d10d', fontsize=16, use_mouse_wheel="true", urgent_alert_method='text', urgent_text="ff5555", disable_drag="true"),
                widget.WindowName(),
                # widget.Spacer(),
                # widget.Sep(foreground='44475a',padding=10),
                # widget.NetGraph(graph_color='f6e71d', border_color='21222c', type='line', line_width=2, margin_y=5, mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e nload -m enp0s29f7u1 nekoray-tun lo')}),
                widget.WidgetBox(widgets=[
                widget.Image(filename='~/.config/qtile/images/wired.png', scale = "False",margin_y=5,mouse_callbacks = {'Button1' : lambda: qtile.cmd_spawn(myTerm2 + ' -e nload -m enp0s29f7u1 lo')}),
                widget.Net(interface="enp0s29f7u1",format='{down}↓↑{up}',mouse_callbacks = {'Button1' : lambda: qtile.cmd_spawn(myTerm2 + ' -e nload -m enp0s29f7u1 lo')}),
                widget.Sep(foreground='44475a',padding=6),
                widget.Image(filename='~/.config/qtile/images/memory.png', scale = "False", margin_y=2,mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm2 + ' -e htop')}),
                widget.Memory(mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')}),
                    ],text_closed="",text_open="",close_button_location='right',fontsize='18'
                ),
                widget.Spacer(length=5, background=None),
                # widget.CPUGraph(border_color="21222c", mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')}),
                widget.Sep(foreground='44475a',padding=6),
                widget.Systray(icon_size=20,padding=6),
                widget.Spacer(length=5, background=None),
                widget.Sep(foreground='44475a',padding=6),
                widget.CurrentLayoutIcon(scale=0.6),
                # widget.Spacer(length=10, background=None),
                widget.Volume(padding=0,fmt='  {}', fontsize=16,scroll_step=10, mouse_callbacks = {'Button3': lambda: qtile.cmd_spawn(pavu)}),
                widget.Spacer(length=10, background=None),
                widget.Clock(background='5bfafa',foreground='000000',font="Ubuntu Bold",fontsize=15,format="%I:%M %p"),

            ],
            35,background=color['background'],margin=8,
        ),
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False #default: True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

floating_layout = layout.Floating(
        border_focus=color['floating'], border_width=3)

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

wmname = "LG3D"
