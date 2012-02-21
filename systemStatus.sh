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
show_user=1
show_uptime=1
show_ram=1
show_load=1
show_battery=1
#
# ### No Change ###
#
# Create Table
system_table=$(
    # user
    if [ "${show_user}" = 1 ]; then
        system_user=$(/usr/bin/w -h | /usr/bin/wc -l | /usr/bin/sed -e 's/ //g')
        /bin/echo "|Users:|${system_user}"
    else
        show_user=0
    fi
    # uptime
    if [ "${show_uptime}" = 1 ]; then
        system_uptime=$(/usr/bin/uptime | /usr/bin/sed -e 's/.*up //;s/,...user.*//;s/1 day/1 Tag/;s/days/Tage/;s/hrs/Stunden/;s/:/ Stunden /;s/1 Stunden/1 Stunde/;s/^1 min/1 Minute/;s/mins/Minuten/;s/secs/Sekunden/;s/.*/&/;s/,//g;s/.*[0-9]$/& Minuten/')
        /bin/echo "|Uptime:|${system_uptime}"
    else
        show_uptime=0
    fi
    # Ram
    if [ "${show_ram}" = 1 ]; then
        system_ram=$(/usr/bin/top -l 1 | /usr/bin/awk '/PhysMem/ {print "Used: " $8 " / Free: " $10}')
        /bin/echo "|Memory:|${system_ram}"
    else
        show_ram=0
    fi
    # load averages
    if [ "${show_load}" = 1 ]; then
        system_load=$(/usr/bin/uptime | /usr/bin/sed -e 's/^.*load averages: //' -e 's/,/./g' | /usr/bin/awk '{print $1 " / " $2 " / " $3}')
        /bin/echo "|Load:|${system_load}"
    else
        show_load=0
    fi
    # battery
    if [ "${show_battery}" = 1 ]; then
        system_battery=$(/usr/sbin/ioreg -l | /usr/bin/grep -i 'capacity' | /usr/bin/tr '\n' ' | ' | /usr/bin/awk '{printf ("%.2f%%", $10/$5 * 100)}')
        /bin/echo "|Battery:|${system_battery}"
    else
        show_battery=0
    fi
)
# count column
system_column=$(/bin/expr 1 + ${show_user} + ${show_uptime} + ${show_ram} + ${show_load} + ${show_battery})
# Output
/bin/echo "${system_table}" | /usr/bin/column -c ${system_column} -s "|" -t
