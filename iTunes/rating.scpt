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
         set rating_count to round ((rating of current track) / 20)
         if rating_count is 1 then
             set rating_text to "★☆☆☆☆"
         else if rating_count is 2 then
             set rating_text to "★★☆☆☆"
         else if rating_count is 3 then
             set rating_text to "★★★☆☆"
         else if rating_count is 4 then
             set rating_text to "★★★★☆"
         else if rating_count is 5 then
             set rating_text to "★★★★★"
         else
             set rating_text to ""
         end if
         set output to rating_text
      end if
   end tell
end if
