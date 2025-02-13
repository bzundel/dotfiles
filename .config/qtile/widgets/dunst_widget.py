import subprocess
from libqtile import widget
from libqtile.lazy import lazy
from libqtile.command.base import expose_command

class DunstWidget(widget.TextBox):
    def __init__(self, show_icon=False, **config):
        super().__init__("", **config)
        self.show_icon = show_icon
        self.active_state = "✓" if show_icon else "active"
        self.inactive_state = "✗" if show_icon else "inactive"
        self.add_callbacks({"Button1": self.toggle_service})

    def _configure(self, qtile, bar):
        super()._configure(qtile, bar)
        self.update_status()

    def update_status(self):
        status = self.get_service_status()
        self.text = f"dunst: {status}"
        self.bar.draw()

    def get_service_status(self):
        try:
            result = subprocess.run(["dunstctl", "is-paused"], capture_output=True, text=True)
            return self.active_state if result.stdout.strip() == "true" else self.inactive_state
        except subprocess.CalledProcessError:
            return "Error"

    def toggle_service(self):
        subprocess.run(["dunstctl", "set-paused", "toggle"])
        self.update_status()

    @expose_command()
    def pause(self):
        subprocess.run(["dunstctl", "set-paused", "true"])
        self.update_status()

    @expose_command()
    def unpause(self):
        subprocess.run(["dunstctl", "set-paused", "false"])
        self.update_status()

