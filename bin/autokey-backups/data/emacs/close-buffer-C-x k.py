import time

# first cancel anything goingon
keyboard.send_keys("<ctrl>+g")

time.sleep(0.25)
keyboard.send_keys("<ctrl>+x")
time.sleep(0.25)
keyboard.send_key("k")
time.sleep(0.25)
keyboard.send_key("<enter>")

