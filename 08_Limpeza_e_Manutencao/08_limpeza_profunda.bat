@echo off
:: Limpeza Profunda de Disco e Temp

echo.
echo [=] Executando Limpeza Profunda de Disco e Temp...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Limpando pasta Temp...
del /f /s /q %temp%\*.* 2>nul

echo [+] Limpando pasta Prefetch...
del /f /s /q %windir%\Prefetch\*.* 2>nul

echo [+] Limpando cache do Installer...
del /f /s /q %windir%\Installer\$PatchCache$\* 2>nul

echo [+] Executando Disk Cleanup...
cleanmgr /sagerun:1

echo [OK] Limpeza profunda concluida.
echo.
echo [INFORMACAO] Libera espaco em disco e melhora desempenho.
echo [V] Limpeza profunda executada!
pause
