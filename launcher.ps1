# ================================================================
# LOBO ALPHA V2.0 - PREMIUM LAUNCHER
# Descarrega e executa a interface Python diretamente do GitHub
# (c) 2026 Lobo Tech - Todos os direitos reservados
# ================================================================

# Verificar administrador
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[!] Este script precisa ser executado como Administrador!" -ForegroundColor Red
    Write-Host "[>] Reiniciando como Admin..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -Command `"iwr -useb https://raw.githubusercontent.com/lobaotech/otzremoto/main/launcher.ps1 | iex`"" -Verb RunAs
    exit
}

$ErrorActionPreference = "SilentlyContinue"
$ProgressPreference = "SilentlyContinue"

Write-Host ""
Write-Host "  ================================================" -ForegroundColor Magenta
Write-Host "  |     LOBO ALPHA V2.0 // PREMIUM LAUNCHER      |" -ForegroundColor Magenta
Write-Host "  |          (c) 2026 Lobo Tech                   |" -ForegroundColor Magenta
Write-Host "  ================================================" -ForegroundColor Magenta
Write-Host ""

# ----------------------------------------------------------------
# FUNCAO: Encontrar Python instalado no sistema
# ----------------------------------------------------------------
function Find-Python {
    # Tentar comandos comuns
    $cmds = @("python", "python3", "py")
    foreach ($cmd in $cmds) {
        try {
            $result = & $cmd --version 2>&1
            if ($result -match "Python 3") {
                # Verificar se nao e o alias da Microsoft Store
                $path = (Get-Command $cmd -ErrorAction SilentlyContinue).Source
                if ($path -and -not ($path -like "*WindowsApps*")) {
                    return $cmd
                }
            }
        } catch {}
    }

    # Procurar em caminhos comuns de instalacao
    $commonPaths = @(
        "$env:LOCALAPPDATA\Programs\Python\Python*\python.exe",
        "$env:ProgramFiles\Python*\python.exe",
        "C:\Python*\python.exe",
        "$env:USERPROFILE\AppData\Local\Programs\Python\Python*\python.exe"
    )
    foreach ($pattern in $commonPaths) {
        $found = Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue | Sort-Object -Descending | Select-Object -First 1
        if ($found) {
            return $found.FullName
        }
    }

    return $null
}

# ----------------------------------------------------------------
# FUNCAO: Instalar Python automaticamente
# ----------------------------------------------------------------
function Install-PythonAuto {
    Write-Host "[>] Python nao encontrado no sistema." -ForegroundColor Yellow
    Write-Host "[>] Descarregando Python 3.12 automaticamente..." -ForegroundColor Cyan
    
    $installerUrl = "https://www.python.org/ftp/python/3.12.8/python-3.12.8-amd64.exe"
    $installerPath = "$env:TEMP\python_installer.exe"
    
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -UseBasicParsing
    } catch {
        Write-Host "[ERRO] Falha ao descarregar Python." -ForegroundColor Red
        Write-Host "[>] Instale manualmente em: https://python.org/downloads" -ForegroundColor Yellow
        Write-Host "[>] IMPORTANTE: Marque 'Add Python to PATH' durante a instalacao!" -ForegroundColor Yellow
        pause
        exit 1
    }
    
    Write-Host "[>] Instalando Python 3.12 (pode demorar 1-2 minutos)..." -ForegroundColor Cyan
    
    # Instalar com PATH e pip incluidos
    Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_pip=1 Include_tcltk=1" -Wait -NoNewWindow
    
    # Limpar instalador
    Remove-Item $installerPath -Force -ErrorAction SilentlyContinue
    
    # Atualizar PATH na sessao atual
    $machinePath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
    $userPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")
    $env:PATH = "$machinePath;$userPath"
    
    # Desativar alias da Microsoft Store para python
    try {
        $aliasPath = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
        $pythonAlias = Join-Path $aliasPath "python.exe"
        $python3Alias = Join-Path $aliasPath "python3.exe"
        if (Test-Path $pythonAlias) { Remove-Item $pythonAlias -Force -ErrorAction SilentlyContinue }
        if (Test-Path $python3Alias) { Remove-Item $python3Alias -Force -ErrorAction SilentlyContinue }
    } catch {}
    
    # Verificar se instalou
    $pythonCmd = Find-Python
    if ($pythonCmd) {
        Write-Host "[OK] Python instalado com sucesso!" -ForegroundColor Green
        return $pythonCmd
    }
    
    # Ultima tentativa: caminho direto
    $directPaths = @(
        "C:\Program Files\Python312\python.exe",
        "C:\Program Files\Python311\python.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python312\python.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python311\python.exe"
    )
    foreach ($p in $directPaths) {
        if (Test-Path $p) {
            Write-Host "[OK] Python encontrado em: $p" -ForegroundColor Green
            return $p
        }
    }
    
    Write-Host "[ERRO] Python foi instalado mas nao foi encontrado no PATH." -ForegroundColor Red
    Write-Host "[>] Feche este terminal e abra novamente, depois execute o comando outra vez." -ForegroundColor Yellow
    pause
    exit 1
}

# ----------------------------------------------------------------
# INICIO DO LAUNCHER
# ----------------------------------------------------------------

Write-Host "[>] Procurando Python no sistema..." -ForegroundColor Cyan

$pythonCmd = Find-Python

if (-not $pythonCmd) {
    $pythonCmd = Install-PythonAuto
}

Write-Host "[OK] Python encontrado: $pythonCmd" -ForegroundColor Green

# Instalar customtkinter
Write-Host "[>] Verificando dependencias (customtkinter)..." -ForegroundColor Cyan
& $pythonCmd -m pip install customtkinter --quiet --disable-pip-version-check 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "[>] Tentando instalar pip primeiro..." -ForegroundColor Yellow
    & $pythonCmd -m ensurepip --upgrade 2>$null
    & $pythonCmd -m pip install customtkinter --quiet 2>$null
}
Write-Host "[OK] Dependencias verificadas!" -ForegroundColor Green

# Descarregar o script Python
Write-Host "[>] Descarregando interface Lobo Alpha V2.0..." -ForegroundColor Cyan
$timestamp = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
$scriptUrl = "https://raw.githubusercontent.com/lobaotech/otzremoto/main/lobo_alpha_v2.py?t=$timestamp"
$scriptPath = "$env:TEMP\lobo_alpha_v2.py"

# Remover versao antiga se existir
if (Test-Path $scriptPath) { Remove-Item $scriptPath -Force }

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $headers = @{ 'Cache-Control' = 'no-cache'; 'Pragma' = 'no-cache' }
    Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath -UseBasicParsing -Headers $headers
} catch {
    Write-Host "[ERRO] Falha ao descarregar a interface." -ForegroundColor Red
    pause
    exit 1
}

if (Test-Path $scriptPath) {
    Write-Host "[OK] Interface descarregada com sucesso!" -ForegroundColor Green
    Write-Host "[>] Iniciando Lobo Alpha V2.0 Premium..." -ForegroundColor Magenta
    Write-Host ""
    
    # Executar a interface Python
    & $pythonCmd $scriptPath
    
    # Limpar
    Remove-Item $scriptPath -Force -ErrorAction SilentlyContinue
} else {
    Write-Host "[ERRO] Ficheiro da interface nao encontrado." -ForegroundColor Red
    pause
}
