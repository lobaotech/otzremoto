@echo off
echo ══════════════════════════════════════════════════
echo   LOBO ALPHA V2.0 - BUILD PARA WINDOWS (.EXE)
echo ══════════════════════════════════════════════════
echo.

REM Verificar se Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERRO] Python nao encontrado! Instale em python.org
    pause
    exit /b 1
)

echo [1/3] Instalando dependencias...
pip install customtkinter pyinstaller --quiet

echo [2/3] Gerando executavel...
pyinstaller --noconfirm --onefile --windowed ^
    --name "LoboAlpha_V2" ^
    --add-data "C:\Users\%USERNAME%\AppData\Local\Programs\Python\*\Lib\site-packages\customtkinter;customtkinter\" ^
    --hidden-import customtkinter ^
    --icon=NONE ^
    lobo_alpha_v2.py

echo [3/3] Limpando arquivos temporarios...
rmdir /s /q build 2>nul
del *.spec 2>nul

echo.
echo ══════════════════════════════════════════════════
echo   BUILD CONCLUIDO!
echo   Executavel em: dist\LoboAlpha_V2.exe
echo ══════════════════════════════════════════════════
pause
