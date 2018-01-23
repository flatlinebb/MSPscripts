@ECHO OFF
FOR /f "usebackq delims== tokens=2" %%x IN (`wmic logicaldisk where "DeviceID='C:'" get FreeSpace /format:value`) DO SET FreeSpace=%%x
SET bytes=%FreeSpace%
ECHO %FreeSpace% bytes
ECHO %bytes%
SET megs=%bytes% / 1024
ECHO %megs% MB
SET hostnamegigs=%megs% / 1024
ECHO %gigs% GB
ECHO Free Space on Drive C: %FreeSpace% bytes
ECHO Free Space on Drive C: %gigs% GB