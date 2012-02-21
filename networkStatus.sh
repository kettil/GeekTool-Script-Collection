#!/bin/bash
#
# Gibt die IP Addressen vom Mac zurück
#
# Author:  Kjell Dießel
# Website: http://www.kettil.de
# License: CC-BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/de/ )
# ---------
#
# command example:
# ./networkStatus "http://www.example.com/ip.php"
#
# Website, where only the external IP address will be given back
#
# Example of a PHP file: <?php echo $_SERVER['REMOTE_ADDR'];
# ---------
#
# list of Interface
network_interface=("en0" "en1")
#
# list of Name from Interface
network_name=("Ethernet" "Wireless")
#
# ### No Change ###
#
# Variable
network_extern="${1}"
#
# Create Table
network_table=$(
    # local IP address from computer
    for (( i=0; i<${#network_interface[@]}; i++ )); do
        /bin/echo -n "|${network_name[i]}:"
        ip=$(/sbin/ifconfig "${network_interface[i]}" | /usr/bin/grep "inet " | /usr/bin/grep -v 127.0.0.1 | /usr/bin/awk '{print $2}')
        if [ "${ip}" != "" ]; then
            /bin/echo -n "|${ip}"
        else
            /bin/echo -n "|OFFLINE"
        fi
        /bin/echo ""
    done
    # external IP address
    if [ "${network_extern}" != "" ]; then
        ip=$(/usr/bin/curl --silent "${network_extern}" | /usr/bin/grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")
        /bin/echo -n "|External:"
        if [ "${ip}" != "" ]; then
            /bin/echo -n "|${ip}"
        else
            /bin/echo -n "|OFFLINE"
        fi
    fi
)
# Output
/bin/echo "${network_table}" | /usr/bin/column -c 2 -s "|" -t
