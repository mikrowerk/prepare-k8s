IGNITION_CONFIG="/home/ansible/images/test.ign"
OS_VARIANT="fedora30"
VM_NAME="fcoreos-nuc-01-vm02"
VCPUS="2"
RAM_MB="2048"

virt-install --connect="qemu:///system" --name="${VM_NAME}" \
        --vcpus="${VCPUS}" \
        --memory="${RAM_MB}" \
        --os-variant="${OS_VARIANT}" \
        --graphics="none" \
        --console pty,target.type=virtio \
        --import \
        --disk="path=/dev/vg-vibvirt-disk-pool/${VM_NAME}" \
        --qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=${IGNITION_CONFIG}" \
        --print-xml
