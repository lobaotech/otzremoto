@echo off
:: Desativar Teclas de Aderencia e Acesso

echo.
echo [=] Desativando Teclas de Aderencia e Acesso...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desativando Sticky Keys...
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d "506" /f

echo [+] Desativando Keyboard Response...
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v Flags /t REG_SZ /d "122" /f

echo [+] Desativando Toggle Keys...
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d "58" /f

echo [OK] Teclas de aderencia desativadas.
echo.
echo [INFORMACAO] Remove atrasos de processamento de teclas causados por recursos de acessibilidade.
echo [V] Teclas de Aderencia desativadas!
pause
