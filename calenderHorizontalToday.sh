#!/bin/bash
#
# Gibt für den horizontalen Kalender den aktuellen Tag zurück
#
# Author:  Kjell Dießel
# Website: http://www.kettil.de
# License: CC-BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/de/ )
# ---------
#
# ### No Change ###
#
# Read Data
today=$(/bin/date +%e)
month=$(/bin/date +%m)
year=$(/bin/date +%Y)
#
# transformation: "02" => "2"
if [ "${today}" -lt 10 ]; then
    today=${today:1:1}
fi
#
# Days of month
if [ "${month}" = "02" ]; then
    if [ $(/bin/expr ${year} % 400) = 0 ] || ( [ $(/bin/expr ${year} % 4) = 0 ] && [ $(/bin/expr ${year} % 100) != 0 ] ); then
        monthDays=29
    else
        monthDays=28
    fi
elif [[ "${month}" == "04" || "${month}" == "06" || "${month}" == "09" || "${month}" == "11" ]]; then
    monthDays=30
else
    monthDays=31
fi
#
# Weekday
for (( i=1; i<${monthDays}; i++ )); do
    if [ "${i}" -ne "${today}" ]; then
        /bin/echo -n "    "
    else
        if [ "${i}" -lt 10 ]; then
            dateString="${month}0${i}0001${year}"
        else
            dateString="${month}${i}0001${year}"
        fi
        /bin/echo -n "$(/bin/date -j ${dateString} +%a)  "
    fi
done
/bin/echo ""
#
# Day
for (( i=1; i<${monthDays}; i++ )); do
    if [ "${i}" -ne "${today}" ]; then
        /bin/echo -n "    "
    else
        if [ "${i}" -lt 10 ]; then
            /bin/echo -n "0"
        fi
        /bin/echo -n "${i}  "
    fi
done
