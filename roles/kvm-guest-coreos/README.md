Role Name
=========

Install a fedora coreos guest on kvm

Preconditions
-------------
handle permission issue
```
sudo usermod -a -G kvm,libvirt,libvirt-qemu ansible

sudo nano /etc/apparmor.d/libvirt/TEMPLATE.qemu
profile LIBVIRT_TEMPLATE flags=(attach_disconnected) {
  #include <abstractions/libvirt-qemu>
  /home/ansible/images/**.* rk,
}

```


fetch image and convert it, if not exists
```
wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/32.20201104.3.0/x86_64/fedora-coreos-32.20201104.3.0-qemu.x86_64.qcow2.xz -O fedora-coreeos-32.qcow2.xz
xz --decompress fedora-coreeos-32.qcow2.xz

qemu-img convert -f qcow2 -O raw fedora-coreeos-32.qcow2 fedora-coreeos-32.raw
```
create logical volume for vm
```
sudo lvcreate -L 50G -n vm-name vg-vibvirt-disk-pool
sudo dd if=fedora-coreeos-32.raw of=/dev/vg-vibvirt-disk-pool/fcoreos-nuc-01-vm1 bs=64K conv=noerror,sync
```


CoreOs
======
OS variables are set with 'config.ign.j2'
user 'core' uses same ssh key as user 'ansible'

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

