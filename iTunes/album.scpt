-- Gibt für den horizontalen Kalender die Tage des aktuellen
-- Monat ohne den aktuellen Tag zurück
--
-- Author:  Kjell Dießel
-- Website: http://www.kettil.de
-- License: CC-BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/de/ )
-- ---------
--
if application "iTunes" is running then
   tell application "iTunes"
      if player state is playing then
         set albumname to album of current track
         set output to albumname
      end if
   end tell
end if
