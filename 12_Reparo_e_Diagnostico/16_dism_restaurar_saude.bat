@echo off
:: DISM Restaurar Saude

echo.
echo [=] Executando DISM Restaurar Saude...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Verificando e reparando imagem do Windows...
DISM /Online /Cleanup-Image /RestoreHealth

echo [OK] DISM concluido.
echo.
echo [INFORMACAO] Repara arquivos corrompidos do Windows.
echo [AVISO] Isto pode levar varios minutos.
echo [V] DISM executado!
pause
