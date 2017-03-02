import subprocess
import time

command = 'wmctrl -l'
output = system.exec_command(command, getOutput=True)

if 'emacs24' in output:
    keyboard.send_keys("<ctrl>+c")
    time.sleep(0.25)
    window.activate('emacs24',switchDesktop=True)
    time.sleep(0.25)
    keyboard.send_keys("<ctrl>+c")
    time.sleep(0.25)
    keyboard.send_keys("c")
    time.sleep(0.25)
    keyboard.send_keys("p")
    time.sleep(0.25)
    keyboard.send_keys("<ctrl>+y")
    time.sleep(0.25)
    keyboard.send_keys("<ctrl>+c")
    time.sleep(0.25)
    keyboard.send_keys("<ctrl>+c")
    time.sleep(0.25)
    keyboard.send_keys("<alt>+<tab>")
    