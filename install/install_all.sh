#!/bin/bash

# Define installation directory
TTDIR=/usr/local/tt

# Update packages and install dependencies
apt-get update
apt-get install -y git virtualenv python-virtualenv cargo dkms

# Configure virtualenv
virtualenv $TTDIR/venv
source $TTDIR/venv/bin/activate

# Upgrade pip and install setuptools
pip install --upgrade pip setuptools

# Create the installation directory if it doesn't exist
if [ ! -d "$TTDIR" ]; then
	    mkdir -p $TTDIR
fi

# Install the driver
cd $TTDIR
git clone https://github.com/tenstorrent/tt-kmd.git
cd tt-kmd
dkms add .
dkms install tenstorrent/1.27.1
modprobe tenstorrent

# Install tt-flash
cd $TTDIR
git clone https://github.com/tenstorrent/tt-flash.git
cd tt-flash
pip install .

# Clone the tt-firmware repository
cd $TTDIR
git clone https://github.com/tenstorrent/tt-firmware.git

# Clone and install tt-smi
git clone https://github.com/tenstorrent/tt-smi.git
cd tt-smi
pip install .
