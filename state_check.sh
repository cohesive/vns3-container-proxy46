#!/bin/bash

# Configuration file path
CONFIG_FILE="/opt/proxy46/proxy46.conf"

# Function to read a variable value from the config file
read_config() {
    grep "^$1=" "$CONFIG_FILE" | awk -F= '{print $2}'
}

# Read variables from the config file
IPV4_ADDR=$(read_config "IPV4_ADDR")
IPV6_ADDR=$(read_config "IPV6_ADDR")
PREFIX=$(read_config "PREFIX")
DYNAMIC_POOL=$(read_config "DYNAMIC_POOL")

# tun driver
if ls /dev/net/tun >/dev/null 2>&1; then
    echo "/dev/net/tun driver exists."
else
    echo "/dev/net/tun driver does not exist."
fi

# proxy46 interface
if ip a s dev proxy46 >/dev/null 2>&1; then
    echo "proxy46 interface exists."
else
    echo "proxy46 interface does not exist."
fi

# ipv4 route
if ip r | grep $DYNAMIC_POOL >/dev/null 2>&1; then
    echo "IPv4 route exists."
else
    echo "IPv4 route does not exist."
fi

# ipv6 route
if ip -6 r | grep $PREFIX >/dev/null 2>&1; then
    echo "IPv6 route exists."
else
    echo "IPv6 route does not exist."
fi

# iptables rule
if iptables -t nat -v -n -L POSTROUTING | grep MASQUERADE | grep $DYNAMIC_POOL >/dev/null 2>&1; then
    echo "MASQERADE rule exists."
else
    echo "MASQUERADE rule does not exist."
fi

# Tayga process
if ps ax | grep -i tayga | grep -v grep >/dev/null 2>&1; then
    echo "Tayga running."
else
    echo "Tayga not running."
fi

