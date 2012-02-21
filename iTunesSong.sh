#!/bin/bash
#
# Proxy-Skript - Gibt den Name des aktuellen Songs zurück
#
# Author:  Kjell Dießel
# Website: http://www.kettil.de
# License: CC-BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/de/ )
# ---------
#
/bin/echo "$(/usr/bin/osascript "$(/usr/bin/dirname "${0}")/iTunes/song.scpt")"

