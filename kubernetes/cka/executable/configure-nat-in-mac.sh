#!/bin/bash
# Configure nat in mac

sudo pfctl -s nat
sudo sysctl -w net.inet.ip.forwarding=1

vi /etc/pf.conf
nat on en0 from 192.168.56.0/24 to any -> (en0)

sudo pfctl -nf /etc/pf.conf
sudo pfctl -f /etc/pf.conf

sudo pfctl -s



