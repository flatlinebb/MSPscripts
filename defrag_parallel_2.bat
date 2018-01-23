defrag /c /h /m /u 

REM Syntax:

        REM defrag <volumes> | /C | /E <volumes>    [/H] [/M | [/U] [/V]]
        REM defrag <volumes> | /C | /E <volumes> /A [/H] [/M | [/U] [/V]]
        REM defrag <volumes> | /C | /E <volumes> /X [/H] [/M | [/U] [/V]]
        REM defrag <volume>                      /T [/H]       [/U] [/V]

REM Parameters:

        REM Value   Description

        REM /A      Perform analysis on the specified volumes.

        REM /C      Perform the operation on all volumes.

        REM /E      Perform the operation on all volumes except those specified.

        REM /H      Run the operation at normal priority (default is low).

        REM /M      Run the operation on each volume in parallel in the background.

        REM /T      Track an operation already in progress on the specified volume.

        REM /U      Print the progress of the operation on the screen.

        REM /V      Print verbose output containing the fragmentation statistics.

        REM /X      Perform free space consolidation on the specified volumes.
