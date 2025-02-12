import os
import subprocess
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord, ScratchPad, DropDown, Match
from libqtile.lazy import lazy
from widgets.systemd_service_widget import SystemdServiceWidget

mod = "mod1"
modsuper = "mod4"
terminal = "alacritty"
hostname = subprocess.check_output(["uname", "-n"]).decode().strip()

hostname_wlan_interface = {
    "cora": "wlp0s20f3",
    "corapad": "wlp3s0",
    "minicora": "wlp0s12f0",
}

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call(["sh", home])

def generate_open_terminal_with_action_command(command):
    return f"{terminal} -e sh -c '{command}; exec $SHELL'"

@lazy.group.function
def unminimize_all(group):
    for win in group.windows:
        if win.minimized:
            win.toggle_minimize()


keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "Return", lazy.layout.swap_main()),

    Key([mod, "shift"], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Exit Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "p", lazy.spawn("dmenu_run")),
    Key([modsuper], "l", lazy.spawn("slock")),
    Key([modsuper, "shift"], "l", lazy.spawn("lock_suspend")),
    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="Switch to next keyboard layout"),
    Key([mod], "b", lazy.hide_show_bar(), desc="Toggle the bar"),

    Key([mod, "shift"], "m", unminimize_all, desc="Unminimize all windows in current group"),

    Key([], "XF86AudioLowerVolume", lazy.widget["volume"].decrease_vol(), desc="Decrease volume"),
    Key([], "XF86AudioRaiseVolume", lazy.widget["volume"].increase_vol(), desc="Increase volume"),
    Key([], "XF86AudioMute", lazy.widget["volume"].mute(), desc="Toggle mute volume"),

    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-)"), desc="Decrease monitor brightness"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 10%+)"), desc="Increase monitor brightness"),

    # open shortcuts
    KeyChord([mod], "o", [
        Key([], "c", lazy.spawn(generate_open_terminal_with_action_command("khal calendar")), desc="Launch new terminal instance showing khal calendar"),
        Key([], "f", lazy.spawn("firefox"), desc="Launch firefox"),
        Key([], "q", lazy.spawn("qutebrowser"), desc="Launch qutebrowser"),
        Key([], "o", lazy.spawn("obsidian"), desc="Launch obsidian"),
        Key([], "k", lazy.spawn("keepassxc"), desc="Launch keepassxc"),
        Key([], "t", lazy.spawn("thunderbird"), desc="Launch thunderbird"),
        Key([], "s", lazy.spawn("signal-desktop"), desc="Launch signal"),
        Key([], "e", lazy.spawn("element-desktop"), desc="Launch element"),
        Key([], "d", lazy.spawn("discord"), desc="Launch discord"),
        Key([], "w", lazy.spawn(generate_open_terminal_with_action_command("weechat")), desc="Launch new terminal instance with weechat"),
        ],
        name="launch"
    ),

    # dunst controls
    KeyChord([mod], "d", [
        Key([], "h", lazy.spawn("dunstctl history-pop"), desc="Show dunst history"),
        Key([], "c", lazy.spawn("dunstctl close-all"), desc="Close all notifications"),
        Key([], "p", lazy.spawn("dunstctl set-paused true"), desc="Pause dunst"),
        Key([], "u", lazy.spawn("dunstctl set-paused false"), desc="Unpause dunst"),
        ],
        name = "dunst"
    ),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups = [
    Group("term"),
    Group("www"),
    Group("dev"),
    Group("rdp"),
    Group("misc"),
    Group("opt", matches=[Match(wm_class=["keepassxc"]), Match(wm_class=["obsidian"])]),
    Group("msg", matches=[Match(wm_class=["thunderbird"]), Match(wm_class=["discord"]), Match(wm_class=["signal"]), Match(wm_class=["element"])]),
    Group("media"),
    ScratchPad("scratchpad", [DropDown("terminal", terminal, opacity=0.8, height=0.8, width=0.8)]),
]

for i, group in enumerate(groups):
    keys.extend([
        Key([mod], str(i + 1), lazy.group[group.name].toscreen(), desc=f"Switch to group {group.name}"),
        Key([mod, "shift"], str(i + 1), lazy.window.togroup(group.name, switch_group=True), desc=f"Switch to and move window to group {group.name}"),
    ])

keys.extend([
    Key([mod], "0", lazy.group["scratchpad"].dropdown_toggle("terminal")),
])

layouts = [
    layout.TreeTab(),
    layout.MonadTall(border_focus="#b200d1", border_width=1)
]

widget_defaults = dict(
    font="terminus",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(name_transform=lambda name: name.upper()),
                widget.Systray(),
                widget.Sep(),
                SystemdServiceWidget(service_name="rclone-onedrive", display_name="Onedrive", show_icon=True),
                widget.Sep(),
                widget.DF(visible_on_warn=False, format="💾 {p} {r:.2f}%"),
                widget.Sep(),
                widget.KeyboardLayout(configured_keyboards=["us", "de"]),
                widget.Sep(),
                widget.Wlan(interface=hostname_wlan_interface[hostname], format="{essid} {percent:2.0%}"),
                widget.Sep(),
                widget.Volume(volume_app="amixer"),
                widget.Sep(),
                widget.Battery(format="{char} {percent:2.0%} {hour:d}:{min:02d}", low_percentage=0.2, notify_below=20, empty_char="🪫", discharge_char="🔋", charge_char="⚡", full_char="🔋"),
                widget.Sep(),
                widget.Clock(format="%Y-%m-%d %a %H:%M", fmt="<b>{}</b>"),
            ],
            24,
        ),
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True

wl_input_rules = None
wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "LG3D"
