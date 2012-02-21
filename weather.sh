#!/bin/bash
#
# Lädt die Wetter-Daten und gibt die Temperatur zurück
#
# Author:  Kjell Dießel
# Website: http://www.kettil.de
# License: CC-BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/de/ )
# ---------
#
# Yahoo-Weather-City url
weather_url="http://ca.weather.yahoo.com/deutschland/bundesland-berlin/berlin-638242"
#
# display options (show: 1; hidden: 0)
show_temperature=1
load_image=1
#
# ### No Change ###
#
# load weather data
weather_data=$(/usr/bin/curl --silent "${weather_url}" | /usr/bin/grep -i "current-weather")
# temperature
if [ "${show_temperature}" = 1 ]; then
    weather_temperature=$(/bin/echo "${weather_data}" | /usr/bin/sed -e 's/^.*"[^"]*day-temp-current[^"]*temp-c[^"]*"[^>]*>[^0-9]*\([0-9\.,]*\).*$/\1/')
    if [ "${#weather_temperature}" != 0 ] && [ "${#weather_temperature}" -le 3 ]; then
        /bin/echo "${weather_temperature}°C"
    fi
fi
# Weather image
if [ "${load_image}" = 1 ]; then
    # url
    weather_image=$(/bin/echo "${weather_data}" | /usr/bin/sed -e "s/^.*background:url('\([^']*\)'.*$/\1/")
    if [ "${weather_image:0:4}" = "http" ]; then
        # load image
        /usr/bin/curl --silent -o "$(/usr/bin/dirname "${0}")/weather/weather.png" "${weather_image}"
    else
        /bin/cp "$(/usr/bin/dirname "${0}")/weather/empty.png" "$(/usr/bin/dirname "${0}")/weather/weather.png"
    fi
fi
