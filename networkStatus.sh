#!/bin/bash
#
# Gibt die IP Addressen vom Mac zurück
#
# Author:  Kjell Dießel
# Website: http://www.kettil.de
# License: CC-BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/de/ )
# ---------
#
# list of Interface
network_interface=("en0" "en1")
#
# list of Name from Interface
network_name=("Ethernet" "Wireless")
#
# Website, where only the external IP address will be given back
#
# Example of a PHP file: <?php echo $_SERVER['REMOTE_ADDR'];
#
network_extern=""
#
# ### No Change ###
#
# Create Table
network_table=$(
    # local IP address from computer
    for (( i=0; i<${#network_interface[@]}; i++ )); do
        echo -n "|${network_name[i]}:"
        ip=$(/sbin/ifconfig "${network_interface[i]}" | /usr/bin/grep "inet " | /usr/bin/grep -v 127.0.0.1 | awk '{print $2}')
        if [ "${ip}" != "" ]; then
            echo -n "|${ip}"
        else
            echo -n "|OFFLINE"
        fi
        echo ""
    done
    # external IP address
    if [ "${network_extern}" != "" ]; then
        ip=$(/usr/bin/curl --silent "${network_extern}" | /usr/bin/grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")
        echo -n "|External:"
        if [ "${ip}" != "" ]; then
            echo -n "|${ip}"
        else
            echo -n "|OFFLINE"
        fi
    fi
)
# Output
/bin/echo "${network_table}" | /usr/bin/column -c 2 -s "|" -t
