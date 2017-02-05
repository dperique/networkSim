#!/bin/bash -x

# Author: F. Dennis Periquet
# Usage:
#
#  dropper.sh <aDecimalPercent> <aLatencyInMs> <interface>
#
# You will need the statistical module for iptables (could mean a kernel update)
# Run this on a Linux machine to drop 25% of traffic on input/output.
# You can tweak the --probability parameter or the -i (for interface).
#
iptables -F
iptables -A INPUT -i $3 -p udp --dport 4500 -m statistic --mode random --probability $1 -j DROP
iptables -A OUTPUT -p udp --dport 4500 -m statistic --mode random --probability $1 -j DROP

# Example: tc qdisc del dev $3 root netem delay 120ms
#
tc qdisc add dev $3 root netem delay $2
tc qdisc add dev $3 root netem delay $2

tc qdisc show dev $3
