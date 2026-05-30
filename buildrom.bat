@echo off
rmdir /s /q temp
rmdir /s /q bin
start make clear && make
pause