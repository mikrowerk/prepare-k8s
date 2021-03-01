# run on each node to ensure that iscsi_tcp is running
sudo systemctl enable --now iscsid
sudo systemctl status iscsid
sudo modprobe iscsi_tcp
lsmod |grep iscsi

