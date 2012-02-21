#!/bin/bash
#
# Zeigt die 13 größten Resourcen-Verbraucher
#
# Author:  Kjell Dießel
# Website: http://www.kettil.de
# License: CC-BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/de/ )
# ---------
#
# ### No Change ###
#
# shows the 13 highest resource consumers
/bin/echo "    CPU    Memory Command"
/bin/echo "$(/bin/ps -arcx -o %cpu,rss,command | /usr/bin/awk '
    {
        if (FNR <= (13 + 1) && $1 != "%CPU" && $1 != "0.0" && $1 != "0,0") {
            printf(" %5.1f%% ", $1);
            printf(" %6.1fMB ", $2 / 1024);
            for (i = 3; i <= NF; i++) {
                printf("%s ", $i);
            }
            printf("\n");
        }
    }'
)"
