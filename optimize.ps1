# 🚀 Script de Otimização Remota - Windows Optimization Toolkit
# Este script executa otimizações básicas diretamente via PowerShell

Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "      WINDOWS OPTIMIZATION TOOLKIT - REMOTE EXEC" -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Verificar privilégios de administrador
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[!] ERRO: Execute o PowerShell como ADMINISTRADOR." -ForegroundColor Red
    exit
}

# 2. Criar Ponto de Restauração (Opcional, mas recomendado)
Write-Host "[*] Criando ponto de restauracao..." -ForegroundColor Yellow
Checkpoint-Computer -Description "Remote_Optimization" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue

# 3. Otimizações de Energia
Write-Host "[*] Ativando Plano de Desempenho Maximo..." -ForegroundColor Green
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

# 4. Limpeza de Arquivos Temporários
Write-Host "[*] Limpando arquivos temporarios..." -ForegroundColor Green
$tempPaths = @("$env:TEMP\*", "$env:SystemRoot\Temp\*", "$env:SystemRoot\Prefetch\*")
foreach ($path in $tempPaths) {
    Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
}

# 5. Otimização de Rede (DNS Cloudflare)
Write-Host "[*] Configurando DNS Cloudflare (1.1.1.1)..." -ForegroundColor Green
$interfaces = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
foreach ($interface in $interfaces) {
    Set-DnsClientServerAddress -InterfaceIndex $interface.ifIndex -ServerAddresses ("1.1.1.1", "1.0.0.1") -ErrorAction SilentlyContinue
}

# 6. Finalização
Write-Host ""
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "   OTIMIZACAO CONCLUIDA! REINICIE O COMPUTADOR." -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "💎 Para otimizacoes AVANCADAS, adquira o PACK PREMIUM!" -ForegroundColor Yellow
Write-Host ""
pause
