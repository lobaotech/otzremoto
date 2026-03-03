@echo off
:: Maximizar Resposta do Teclado

echo.
echo [=] Maximizando Resposta do Teclado...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Configurando velocidade do teclado para maxima...
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d "31" /f

echo [+] Configurando delay do teclado para minimo...
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d "1" /f

echo [+] Configurando taxa de repeticao...
reg add "HKCU\Control Panel\Keyboard" /v AutoRepeatRate /t REG_SZ /d "500" /f

echo [OK] Resposta do teclado maximizada.
echo.
echo [INFORMACAO] Aumenta a velocidade de repeticao de teclas para resposta mais rapida.
echo [V] Resposta do Teclado maximizada!
pause
