sudo cp 49-bob.rules /etc/udev/rules.d
sudo udevadm control --reload-rules && sudo udevadm trigger