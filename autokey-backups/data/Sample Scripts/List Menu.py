choices = ["94.74.128.14", "172.16.8.15", "127.0.0.1","192.168.1.1", "987654321"]

retCode, choice = dialog.list_menu(choices)
if retCode == 0:
    keyboard.send_keys(choice)

