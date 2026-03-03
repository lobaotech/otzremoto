@echo off
color 0A
title Limpar Cache Shader AMD

echo ==================================================
echo            LIMPAR CACHE SHADER AMD
echo ==================================================

echo Este script limpa os caches de shader da AMD.
echo Isso pode resolver problemas de stuttering ou artefatos graficos.
echo.
pause

echo [1/2] Limpando cache DirectX da AMD...
del /s /q "%LOCALAPPDATA%\AMD\DxCache\*"

echo [2/2] Limpando cache OpenGL da AMD...
del /s /q "%LOCALAPPDATA%\AMD\GLCache\*"

echo ==================================================
echo Caches de shader AMD limpos.
echo ==================================================
pause
exit
