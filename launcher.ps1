# ══════════════════════════════════════════════════════════════
# LOBO ALPHA V2.0 - LAUNCHER REMOTO
# Descarrega e executa a interface Python diretamente do GitHub
# ══════════════════════════════════════════════════════════════

# Verificar administrador
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[!] Este script precisa ser executado como Administrador!" -ForegroundColor Red
    Write-Host "[>] Reiniciando como Admin..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$ErrorActionPreference = "SilentlyContinue"
$ProgressPreference = "SilentlyContinue"

Write-Host ""
Write-Host "  ╔══════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "  ║     LOBO ALPHA V2.0 // PREMIUM LAUNCHER     ║" -ForegroundColor Magenta
Write-Host "  ║          © 2026 Lobo Tech                    ║" -ForegroundColor Magenta
Write-Host "  ╚══════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

# Verificar se Python está instalado
$pythonCmd = $null
if (Get-Command python -ErrorAction SilentlyContinue) {
    $pythonCmd = "python"
} elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    $pythonCmd = "python3"
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    $pythonCmd = "py"
}

if (-not $pythonCmd) {
    Write-Host "[!] Python nao encontrado. Instalando automaticamente..." -ForegroundColor Yellow
    Write-Host "[>] Descarregando Python 3.12..." -ForegroundColor Cyan
    
    $pythonInstaller = "$env:TEMP\python_installer.exe"
    Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe" -OutFile $pythonInstaller -UseBasicParsing
    
    Write-Host "[>] Instalando Python (silencioso)..." -ForegroundColor Cyan
    Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_pip=1" -Wait
    Remove-Item $pythonInstaller -Force
    
    # Atualizar PATH
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
    
    if (Get-Command python -ErrorAction SilentlyContinue) {
        $pythonCmd = "python"
        Write-Host "[OK] Python instalado com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "[ERRO] Falha ao instalar Python. Instale manualmente em python.org" -ForegroundColor Red
        pause
        exit 1
    }
}

Write-Host "[>] Python encontrado: $pythonCmd" -ForegroundColor Green

# Instalar customtkinter
Write-Host "[>] Verificando dependencias..." -ForegroundColor Cyan
& $pythonCmd -m pip install customtkinter --quiet 2>$null

# Descarregar o script Python
Write-Host "[>] Descarregando interface Lobo Alpha V2.0..." -ForegroundColor Cyan
$scriptUrl = "https://raw.githubusercontent.com/lobaotech/otzremoto/main/lobo_alpha_v2.py"
$scriptPath = "$env:TEMP\lobo_alpha_v2.py"

Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath -UseBasicParsing

if (Test-Path $scriptPath) {
    Write-Host "[OK] Interface descarregada com sucesso!" -ForegroundColor Green
    Write-Host "[>] Iniciando Lobo Alpha V2.0 Premium..." -ForegroundColor Magenta
    Write-Host ""
    
    # Executar a interface Python
    & $pythonCmd $scriptPath
    
    # Limpar
    Remove-Item $scriptPath -Force -ErrorAction SilentlyContinue
} else {
    Write-Host "[ERRO] Falha ao descarregar a interface." -ForegroundColor Red
    pause
}
