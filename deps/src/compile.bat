@echo off

if "%1" == "" goto all

if /i %1 == all       goto all
if /i %1 == clean     goto all
if /i %1 == compile   goto compile

:all
nmake -f makefile.win clean 
if /i %1 == clean     goto :eof

:compile
nmake -f makefile.win
goto :eof

:missing
echo The specified configuration type is missing.  The tools for the
echo configuration might not be installed.
goto :eof