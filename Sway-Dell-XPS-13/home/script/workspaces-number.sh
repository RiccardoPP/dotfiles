#
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
#

import subprocess

from i3ipc import Connection, Event
timeout = 600


def notify(i3, e):
    con = i3.get_tree().find_focused()
    msg = con.workspace().num  # or use 'con.workspace().name' for workspace name
    subprocess.Popen('exec notify-send -t {} {}'.format(timeout, msg), shell=True)


def main():
    i3 = Connection()
    i3.on(Event.WORKSPACE_FOCUS, notify)
    i3.main()


if __name__ == "__main__":
    main()
