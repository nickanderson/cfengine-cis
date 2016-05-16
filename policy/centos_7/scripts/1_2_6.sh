#!/bin/bash

rpm -qVa | awk '$2 != "c" { print $0}' | grep -v /var/run/wpa_supplicant | grep -v /var/lib/nfs/rpc_pipefs
