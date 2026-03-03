@echo off
color 0A
title Limpar Cache Shader Intel

echo ==================================================
echo           LIMPAR CACHE SHADER INTEL
echo ==================================================

echo Este script limpa os caches de shader da Intel.
echo Isso pode resolver problemas de stuttering ou artefatos graficos.
echo.
pause

echo [1/3] Limpando cache de shader na pasta AppData\Local\Intel...
del /s /q "%LOCALAPPDATA%\Intel\ShaderCache\*"

echo [2/3] Limpando cache de shader na pasta AppData\LocalLow\Intel...
del /s /q "%LOCALAPPDATA%\..\LocalLow\Intel\ShaderCache\*"

echo [3/3] Limpando cache de shader na pasta ProgramData\Intel...
del /s /q "%PROGRAMDATA%\Intel\ShaderCache\*"

echo ==================================================
echo Caches de shader Intel limpos.
echo ==================================================
pause
exit
