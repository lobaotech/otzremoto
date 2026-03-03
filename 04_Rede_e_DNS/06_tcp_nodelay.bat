@echo off
:: TCP No Delay & AckFreq (Desativa Nagle's Algorithm)

echo.
echo [=] Desativando Nagle's Algorithm (TCP No Delay)...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Aplicando TCPNoDelay=1 globalmente...
reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f

echo [+] Aplicando TCPNoDelay a todos os adaptadores de rede...
FOR /F "tokens=*" %%G IN ('reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces') DO (
    reg add "%%G" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%G" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
)

echo [OK] Nagle's Algorithm desativado.
echo.
echo [INFORMACAO] Reduz latencia enviando pacotes imediatamente sem aguardar confirmacao.
echo [V] TCP No Delay ativado!
pause
