@echo off
:: Resetar Cache de Shader

echo.
echo [=] Resetando Cache de Shader...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Removendo cache de shader NVIDIA...
del /s /q %localappdata%\NVIDIA\GLCache\*.* 2>nul

echo [+] Removendo cache de shader AMD...
del /s /q %localappdata%\AMD\DxCache\*.* 2>nul

echo [+] Removendo cache D3D...
del /s /q %localappdata%\D3DSCache\*.* 2>nul

echo [OK] Cache de shader resetado.
echo.
echo [INFORMACAO] Libera espaco em disco. Cache sera recriado automaticamente.
echo [V] Cache de shader resetado!
pause
