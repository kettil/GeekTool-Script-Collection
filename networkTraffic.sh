#!/bin/bash
#
# Gibt den aktuellen Traffic vom entsprechenden Network-Interface
#
# Author:  Kjell Dießel
# Website: http://www.kettil.de
# License: CC-BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/de/ )
# ---------
#
# command example:
# ./networkTraffic "en0" "Ethernet"
# ./networkTraffic "en1" "Wireless"
# ---------
#
# ### No Change ###
#
# Variable
network_interface="${1}"
network_name="${2}"

# whether the interface is passed
if [ "${network_interface}" = "" ]; then
    /bin/echo "missing or wrong Parameter"
    exit -1
fi

# get the current number of bytes input
function getBytesInput()
{
    /bin/echo "$(/usr/sbin/netstat -ib | /usr/bin/grep -e "${1}" -m 1 | /usr/bin/awk '{print $7}')"
}

# get the current number of bytes output
function getBytesOutput()
{
    /bin/echo "$(/usr/sbin/netstat -ib | /usr/bin/grep -e "${1}" -m 1 | /usr/bin/awk '{print $10}')"
}

# convert bytes to kilobytes or kilobytes in megabytes
function convertBytes()
{
    /bin/echo $(/bin/echo "scale=2; ${1}/1024;" | /usr/bin/bc | /usr/bin/sed -e 's/^\./0./' -e 's/^\([^\.]*\)$/\1.00/' -e 's/\(.*\)\.\([0-9]\)$/\1.\20/')
}

# get the current number of bytes in and bytes out
network_input=$(getBytesInput "${network_interface}")
network_output=$(getBytesOutput "${network_interface}")
#wait one second
/bin/sleep 1
# get the number of bytes in and out one second later and find
# the difference between bytes in and out during that one second
network_input=$(/bin/expr $(getBytesInput "${network_interface}") - ${network_input})
network_output=$(/bin/expr $(getBytesOutput "${network_interface}") - ${network_output})

# convert bytes to kilobytes
network_input=$(convertBytes "${network_input}")
network_output=$(convertBytes "${network_output}")

# unit of input: megabytes or kilobytes
if [ ${#network_input} -gt 6 ]; then
    network_input=$(convertBytes "${network_input}")
    unit_input="M"
else
    unit_input="K"
fi
# unit of output: megabytes or kilobytes
if [ ${#network_output} -gt 6 ]; then
    network_output=$(convertBytes "${network_output}")
    unit_output="M"
else
    unit_output="K"
fi

# cosmetic
network_input=$(/bin/echo "${network_input}"   | /usr/bin/sed -e 's/^\([0-9]\.[0-9]*\)$/  \1/' -e 's/^\([0-9][0-9]\.[0-9]*\)$/ \1/')
network_output=$(/bin/echo "${network_output}" | /usr/bin/sed -e 's/^\([0-9]\.[0-9]*\)$/  \1/' -e 's/^\([0-9][0-9]\.[0-9]*\)$/ \1/')

# print the results
if [ "${network_name}" != "" ]; then
    /bin/echo "${network_name}"
fi
/bin/echo "IN:  ${network_input} ${unit_input}Bytes/s"
/bin/echo "OUT: ${network_output} ${unit_output}Bytes/s"
