#!/bin/bash
#
# Gibt die Festplattenbelegung zurück
#
# Author:  Kjell Dießel
# Website: http://www.kettil.de
# License: CC-BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/de/ )
# ---------
#
# display options (show: 1; hidden: 0)
show_size=0
show_used=0
show_free=1
show_capa=1
#
# ### No Change ###
#
# Pad a string to a certain length with another string
function str_pad()
{
    pad_key="${1}"
    pad_value="${2}"
    i=$(/bin/expr $(/bin/echo "${pad_key}" | /usr/bin/wc -c) - $(/bin/echo "${pad_value}" | /usr/bin/wc -c))
    while [ ${i} -gt 0 ]; do
        pad_value="_${pad_value}"
        i=$(/bin/expr ${i} - 1)
    done
    /bin/echo "${pad_value}"
}
#
# Create Table
hdd_table=$(
    # table legende
    /bin/echo -n "|Volume"
    if [ "${show_size}" = 1 ]; then
        /bin/echo -n "|Size"
    else
        show_size=0
    fi
    if [ "${show_used}" = 1 ]; then
        /bin/echo -n "|Used"
    else
        show_used=0
    fi
    if [ "${show_free}" = 1 ]; then
        /bin/echo -n "|Free"
    else
        show_free=0
    fi
    if [ "${show_capa}" = 1 ]; then
        /bin/echo -n "|Capacity"
    else
        show_capa=0
    fi
    /bin/echo ""
    #
    # HDD
    /bin/ls /Volumes/ | /usr/bin/grep -v "WD SmartWare" | /usr/bin/grep -v "MobileBackups" | while read HDD; do
        status=$(df -H /Volumes/"${HDD}")
        # Name
        /bin/echo -n "|${HDD}"
        # Size
        if [ "${show_size}" = 1 ]; then
            /bin/echo -n "|$(str_pad "Size" $(/bin/echo ${status} | /usr/bin/awk '{print $9}'))"
        fi
        # Used
        if [ "${show_used}" = 1 ]; then
        /bin/echo -n "|$(str_pad "Used" $(/bin/echo ${status} | /usr/bin/awk '{print $10}'))"
        fi
        # Avail
        if [ "${show_free}" = 1 ]; then
        /bin/echo -n "|$(str_pad "Free" $(/bin/echo ${status} | /usr/bin/awk '{print $11}'))"
        fi
        # Capacity
        if [ "${show_capa}" = 1 ]; then
        /bin/echo -n "|$(str_pad "Capacity" $(/bin/echo ${status} | /usr/bin/awk '{print $12}'))"
        fi
        /bin/echo ""
    done
)
# clear table
hdd_table=$(/bin/echo "${hdd_table}" | /usr/bin/sed 's/BOOTCAMP/Windows 7/g' | /usr/bin/sed 's/_/ /g' | /usr/bin/sed 's/ |/|/g')
# count column
hdd_column=$(/bin/expr 1 + ${show_size} + ${show_free} + ${show_free} + ${show_capa})
# Output
/bin/echo "${hdd_table}" | /usr/bin/column -c ${hdd_column} -s "|" -t
