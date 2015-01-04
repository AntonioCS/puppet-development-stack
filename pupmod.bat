@echo off
SET modulesdir=modules
SET modulesdirfullpath="%CD%\%modulesdir%\"

rem Usage phpmod.bat <Action> [params]
rem This will then add the option --modulespath and pass it the current directory plus the modulesdir 
rem Actions must come before Options

puppet module %* --modulepath %modulesdirfullpath%