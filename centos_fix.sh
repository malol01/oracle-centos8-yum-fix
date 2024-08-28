#!/bin/bash

# Create a backup of the existing repository configurations
mkdir -p /etc/yum.repos.d/backup
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup/

# Create a new repository file for CentOS 8 with Vault URLs
cat <<EOF | sudo tee /etc/yum.repos.d/CentOS-Vault.repo
[base]
name=CentOS-8 - Base
baseurl=http://vault.centos.org/8.5.2111/BaseOS/x86_64/os/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[appstream]
name=CentOS-8 - AppStream
baseurl=http://vault.centos.org/8.5.2111/AppStream/x86_64/os/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[extras]
name=CentOS-8 - Extras
baseurl=http://vault.centos.org/8.5.2111/extras/x86_64/os/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[centosplus]
name=CentOS-8 - CentOSPlus
baseurl=http://vault.centos.org/8.5.2111/centosplus/x86_64/os/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF

# Try to install the missing 'librepo' module if necessary
sudo yum install -y python3-librepo || echo "librepo module not found or already installed"

# Disable the osmsplugin if it is not needed
if [ -f /etc/yum/pluginconf.d/osmsplugin.conf ]; then
    sudo sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/osmsplugin.conf
fi

# Clean the YUM cache and update the system
sudo yum clean all
sudo yum update -y
