# ==================================================================================================
# 🚀 OTIMIZADOR DE PC REMOTO - v3.1 SUPERIOR
# ==================================================================================================
#
# Este script baixa e executa o Pack de Otimização Premium diretamente do GitHub.
# Interface interativa para selecionar e aplicar otimizações em tempo real.
#
# ==================================================================================================

# --- CONFIGURAÇÕES --- #
$RepoOwner = "lobaotech"
$RepoName = "otzremoto"
$Branch = "main"
$BaseUrl = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch"

# --- VERIFICAÇÃO DE ADMINISTRADOR --- #
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "ERRO: Este script precisa ser executado como Administrador."
    Write-Warning "Clique com o botão direito no PowerShell e selecione 'Executar como Administrador'."
    Read-Host "Pressione Enter para sair..."
    exit
}

# --- FUNÇÕES CORE --- #

# Função para baixar conteúdo de um script do GitHub
function Get-RemoteScriptContent($RelativePath) {
    $Url = "$BaseUrl/$($RelativePath.Replace(' ', '%20'))"
    try {
        $response = Invoke-WebRequest -Uri $Url -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            return $response.Content
        } else {
            Write-Error "Falha ao baixar o script: $($response.StatusCode) - $Url"
            return $null
        }
    } catch {
        Write-Error "Exceção ao baixar o script: $_ - $Url"
        return $null
    }
}

# Função para executar um bloco de script (BAT ou REG)
function Invoke-ScriptBlockFromContent($Content, $Type) {
    $tempFile = New-Item -Path $env:TEMP -Name "temp_script.$Type" -ItemType File -Force
    Set-Content -Path $tempFile.FullName -Value $Content -Encoding Ascii

    if ($Type -eq "bat") {
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$($tempFile.FullName)`"" -Wait -Verb RunAs
    } elseif ($Type -eq "reg") {
        Start-Process -FilePath "reg.exe" -ArgumentList "import `"$($tempFile.FullName)`"" -Wait -Verb RunAs
    }

    Remove-Item -Path $tempFile.FullName -Force
}

# --- DEFINIÇÃO DOS MÓDULOS DE OTIMIZAÇÃO --- #

$OptimizationModules = @(
    @{ Name = "Preparação e Backup"; Path = "01_Preparacao_e_Backup"; Scripts = @("01_CRIAR_PONTO_RESTAURACAO.bat", "02_BACKUP_REGISTRO_COMPLETO.bat"); Selected = $false },
    @{ Name = "Otimização de CPU e Energia"; Path = "02_Otimizacao_CPU_e_Energia"; Scripts = @("01_plano_desempenho_maximo.bat", "02_desbloquear_atributos_energia.bat", "04_prioridade_cpu_amd.bat", "06_desativar_core_parking.bat", "07_win32_priority_separation.bat", "08_desativar_estrangulamento_energia.bat", "09_limpar_planos_energia.bat", "Planos_Especificos/01_plano_energia_amd.bat", "Planos_Especificos/02_plano_energia_intel.bat", "otimizacoes_energia.reg"); Selected = $false },
    @{ Name = "Otimização de GPU e Vídeo"; Path = "03_Otimizacao_GPU_e_Video"; Scripts = @("03_agendador_multimidia_jogos.bat", "05_agendamento_gpu_hardware.bat", "06_escala_gpu.bat", "09_gamedvr_tela_cheia.bat", "12_resetar_cache_shader.bat", "15_bloquear_updates_driver.bat", "Limpeza_Cache_Shader/01_limpar_cache_nvidia.bat", "Limpeza_Cache_Shader/02_limpar_cache_amd.bat", "Limpeza_Cache_Shader/03_limpar_cache_intel.bat"); Selected = $false },
    @{ Name = "Rede e DNS"; Path = "04_Rede_e_DNS"; Scripts = @("01_reset_rede.bat", "02_receive_side_scaling.bat", "03_tcp_autotuning.bat", "04_mtu_1400.bat", "05_desativar_ipv6.bat", "06_tcp_nodelay.bat", "07_indice_estrangulamento.bat", "08_tcp_coalescing.bat", "09_remover_qos.bat", "10_limpar_dns.bat", "11_dns_cloudflare.bat", "12_dns_google.bat", "13_dns_opendns.bat", "otimizacoes_rede.reg", "otimizador_rede.bat"); Selected = $false },
    @{ Name = "Input Lag e Periféricos"; Path = "05_Input_Lag_e_Perifericos"; Scripts = @("01_buffers_entrada.bat", "02_resposta_teclado.bat", "03_desativar_hpet.bat", "04_economia_usb.bat", "05_modo_msi.bat", "07_timer_resolution.bat", "08_aceleracao_mouse.bat", "09_teclas_aderencia.bat", "10_diagnostico_dpc.bat", "otimizacoes_input_lag.reg", "otimizador_input_lag.bat"); Selected = $false },
    @{ Name = "Memória RAM"; Path = "06_Memoria_RAM"; Scripts = @("01_ajustes_memoria_ram.bat"); Selected = $false },
    @{ Name = "Debloater e Privacidade"; Path = "07_Debloater_e_Privacidade"; Scripts = @("01_remover_xbox_apps.bat", "02_remover_cortana.bat", "03_remover_teams.bat", "04_remover_onedrive.bat"); Selected = $false },
    @{ Name = "Limpeza e Manutenção"; Path = "08_Limpeza_e_Manutencao"; Scripts = @("08_limpeza_profunda.bat", "11_limpar_logs_eventos.bat", "13_remover_bloatware.bat"); Selected = $false },
    @{ Name = "Inicialização e Serviços"; Path = "09_Inicializacao_e_Servicos"; Scripts = @("01_desativar_superfetch.bat", "02_otimizar_servicos_jogos.bat", "03_otimizar_boot.bat", "04_desativar_apps_inicializacao.bat", "05_desativar_indexacao.bat", "06_desativar_spooler.bat", "07_desativar_windows_update.bat", "10_resetar_cache_update.bat", "14_desativar_apps_segundo_plano.bat"); Selected = $false },
    @{ Name = "Otimizações por Jogo"; Path = "10_Otimizacoes_por_Jogo"; Scripts = @("01_otimizar_jogo_generico.bat", "02_otimizar_cs2.bat", "03_otimizar_fortnite.bat", "04_otimizar_valorant.bat", "05_otimizar_gta_v.bat", "06_otimizar_fivem.bat", "07_otimizar_roblox.bat", "08_otimizar_minecraft.bat", "09_otimizar_battlefield.bat", "10_otimizar_rdr2.bat"); Selected = $false },
    @{ Name = "Extras e Componentes"; Path = "11_Extras_e_Componentes"; Scripts = @("20_privacidade_debloat.bat", "21_instalar_componentes.bat", "22_otimizacao_ssd_nvme.bat", "23_latencia_audio.bat", "scripts_reg/privacidade_debloat.reg"); Selected = $false },
    @{ Name = "Reparo e Diagnóstico"; Path = "12_Reparo_e_Diagnostico"; Scripts = @("16_dism_restaurar_saude.bat", "17_sfc_scannow.bat", "18_agendar_chkdsk.bat", "19_atualizar_drivers_so.bat"); Selected = $false },
    @{ Name = "Ferramentas de Terceiros"; Path = "13_Ferramentas_Terceiros"; Scripts = @("01_baixar_ferramentas.bat"); Selected = $false }
)

# --- LÓGICA DO MENU --- #

function Show-Menu {
    Clear-Host
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "   OTIMIZADOR DE PC REMOTO - v3.1 SUPERIOR" -ForegroundColor White
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "Selecione os módulos de otimização que deseja aplicar:" -ForegroundColor Yellow
    Write-Host ""

    for ($i = 0; $i -lt $OptimizationModules.Count; $i++) {
        $module = $OptimizationModules[$i]
        $status = if ($module.Selected) { "[X]" } else { "[ ]" }
        Write-Host ("{0,3}. {1} {2}" -f ($i + 1), $status, $module.Name)
    }

    Write-Host ""
    Write-Host "--------------------------------------------------" -ForegroundColor Gray
    Write-Host " A. Selecionar Todos" -ForegroundColor Green
    Write-Host " L. Limpar Seleção" -ForegroundColor Yellow
    Write-Host " G. GO! Iniciar Otimização" -ForegroundColor Cyan
    Write-Host " S. Sair" -ForegroundColor Red
    Write-Host "--------------------------------------------------" -ForegroundColor Gray
}

# --- LOOP PRINCIPAL --- #

do {
    Show-Menu
    $input = Read-Host "Digite os números (separados por vírgula), ou uma opção (A,L,G,S)"

    if ($input -eq 'S') { break }

    if ($input -eq 'A') {
        $OptimizationModules.ForEach({ $_.Selected = $true })
        continue
    }

    if ($input -eq 'L') {
        $OptimizationModules.ForEach({ $_.Selected = $false })
        continue
    }

    if ($input -eq 'G') {
        $selectedModules = $OptimizationModules | Where-Object { $_.Selected -eq $true }
        if ($selectedModules.Count -eq 0) {
            Write-Warning "Nenhum módulo selecionado!"
            Read-Host "Pressione Enter para continuar..."
            continue
        }

        Clear-Host
        Write-Host "==================================================" -ForegroundColor Cyan
        Write-Host "      INICIANDO OTIMIZAÇÃO..." -ForegroundColor White
        Write-Host "==================================================" -ForegroundColor Cyan

        foreach ($module in $selectedModules) {
            Write-Host "`n[MODULO] $($module.Name)" -ForegroundColor Yellow
            foreach ($scriptName in $module.Scripts) {
                $relativePath = "$($module.Path)/$scriptName"
                Write-Host "  -> Baixando e executando: $scriptName"
                $content = Get-RemoteScriptContent -RelativePath $relativePath
                if ($content) {
                    $extension = [System.IO.Path]::GetExtension($scriptName).TrimStart('.')
                    Invoke-ScriptBlockFromContent -Content $content -Type $extension
                }
            }
        }

        Write-Host "`n==================================================" -ForegroundColor Green
        Write-Host "   OTIMIZAÇÃO CONCLUÍDA!" -ForegroundColor White
        Write-Host "   É altamente recomendável reiniciar o computador." -ForegroundColor Yellow
        Write-Host "==================================================" -ForegroundColor Green
        Read-Host "Pressione Enter para finalizar..."
        break
    }

    # Processar seleção de números
    $input.Split(',') | ForEach-Object {
        $num = $_.Trim()
        if ($num -match '^\d+$') {
            $index = [int]$num - 1
            if ($index -ge 0 -and $index -lt $OptimizationModules.Count) {
                $OptimizationModules[$index].Selected = -not $OptimizationModules[$index].Selected
            }
        }
    }

} while ($true)
