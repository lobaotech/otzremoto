@echo off
:: Desativar Indexacao de Pesquisa do Windows

echo.
echo [=] Desativando Indexacao de Pesquisa do Windows...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Parando servico de indexacao...
sc stop "wsearch"

echo [+] Desativando na inicializacao...
sc config "wsearch" start=disabled

echo [OK] Indexacao desativada.
echo.
echo [INFORMACAO] Libera CPU e SSD ao desativar indexacao de pesquisa.
echo [AVISO] A busca do Windows ficara mais lenta.
echo [V] Indexacao desativada!
pause
