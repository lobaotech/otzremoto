@echo off
color 0A
title Limpar Cache Shader NVIDIA

echo ==================================================
echo           LIMPAR CACHE SHADER NVIDIA
echo ==================================================

echo Este script limpa os caches de shader da NVIDIA.
echo Isso pode resolver problemas de stuttering ou artefatos graficos.
echo.
pause

echo [1/2] Limpando cache DirectX da NVIDIA...
del /s /q "%LOCALAPPDATA%\NVIDIA\DXCache\*"

echo [2/2] Limpando cache OpenGL da NVIDIA...
del /s /q "%LOCALAPDATA%\NVIDIA\GLCache\*"

echo ==================================================
echo Caches de shader NVIDIA limpos.
echo ==================================================
pause
exit
