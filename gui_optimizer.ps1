# ==================================================================================================
# 🚀 OTIMIZADOR DE PC REMOTO - GUI v1.1 (CORRIGIDO)
# ==================================================================================================
#
# Este script cria uma interface gráfica para selecionar e executar otimizações do Pack Premium
# diretamente do GitHub. Inspirado no WinUtil, com abas e checkboxes.
#
# ==================================================================================================

# --- CONFIGURAÇÕES --- #
$RepoOwner = "lobaotech"
$RepoName = "otzremoto"
$Branch = "main"
$BaseUrl = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch"

# --- VERIFICAÇÃO DE ADMINISTRADOR --- #
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.MessageBox]::Show("Este script precisa ser executado como Administrador.", "Erro de Permissão", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
    exit
}

# --- CARREGAR ASSEMBLIES NECESSÁRIOS PARA GUI --- #
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- FUNÇÕES CORE --- #

# Função para baixar conteúdo de um script do GitHub
function Get-RemoteScriptContent($RelativePath) {
    $Url = "$BaseUrl/$($RelativePath.Replace(" ", "%20"))"
    try {
        $response = Invoke-WebRequest -Uri $Url -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            return $response.Content
        } else {
            return $null
        }
    } catch {
        return $null
    }
}

# Função para executar um bloco de script (BAT ou REG)
function Invoke-ScriptBlockFromContent($Content, $Type) {
    $tempFile = New-Item -Path $env:TEMP -Name "temp_script.$Type" -ItemType File -Force
    Set-Content -Path $tempFile.FullName -Value $Content -Encoding Ascii

    if ($Type -eq "bat") {
        $process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$($tempFile.FullName)`"" -PassThru -WindowStyle Hidden
        $process.WaitForExit()
    } elseif ($Type -eq "reg") {
        $process = Start-Process -FilePath "reg.exe" -ArgumentList "import `"$($tempFile.FullName)`"" -PassThru -WindowStyle Hidden
        $process.WaitForExit()
    }

    Remove-Item -Path $tempFile.FullName -Force -ErrorAction SilentlyContinue
}

# --- DEFINIÇÃO DOS MÓDULOS DE OTIMIZAÇÃO --- #

$OptimizationCategories = @(
    @{ Name = "Preparação"; Path = "01_Preparacao_e_Backup"; Scripts = @("01_CRIAR_PONTO_RESTAURACAO.bat", "02_BACKUP_REGISTRO_COMPLETO.bat") },
    @{ Name = "CPU & Energia"; Path = "02_Otimizacao_CPU_e_Energia"; Scripts = @("01_plano_desempenho_maximo.bat", "02_desbloquear_atributos_energia.bat", "04_prioridade_cpu_amd.bat", "06_desativar_core_parking.bat", "07_win32_priority_separation.bat", "08_desativar_estrangulamento_energia.bat", "09_limpar_planos_energia.bat", "Planos_Especificos/01_plano_energia_amd.bat", "Planos_Especificos/02_plano_energia_intel.bat", "otimizacoes_energia.reg") },
    @{ Name = "GPU & Vídeo"; Path = "03_Otimizacao_GPU_e_Video"; Scripts = @("03_agendador_multimidia_jogos.bat", "05_agendamento_gpu_hardware.bat", "06_escala_gpu.bat", "09_gamedvr_tela_cheia.bat", "12_resetar_cache_shader.bat", "15_bloquear_updates_driver.bat", "Limpeza_Cache_Shader/01_limpar_cache_nvidia.bat", "Limpeza_Cache_Shader/02_limpar_cache_amd.bat", "Limpeza_Cache_Shader/03_limpar_cache_intel.bat") },
    @{ Name = "Rede & DNS"; Path = "04_Rede_e_DNS"; Scripts = @("01_reset_rede.bat", "02_receive_side_scaling.bat", "03_tcp_autotuning.bat", "04_mtu_1400.bat", "05_desativar_ipv6.bat", "06_tcp_nodelay.bat", "07_indice_estrangulamento.bat", "08_tcp_coalescing.bat", "09_remover_qos.bat", "10_limpar_dns.bat", "11_dns_cloudflare.bat", "12_dns_google.bat", "13_dns_opendns.bat", "otimizacoes_rede.reg", "otimizador_rede.bat") },
    @{ Name = "Input Lag"; Path = "05_Input_Lag_e_Perifericos"; Scripts = @("01_buffers_entrada.bat", "02_resposta_teclado.bat", "03_desativar_hpet.bat", "04_economia_usb.bat", "05_modo_msi.bat", "07_timer_resolution.bat", "08_aceleracao_mouse.bat", "09_teclas_aderencia.bat", "10_diagnostico_dpc.bat", "otimizacoes_input_lag.reg", "otimizador_input_lag.bat") },
    @{ Name = "Memória RAM"; Path = "06_Memoria_RAM"; Scripts = @("01_ajustes_memoria_ram.bat") },
    @{ Name = "Debloater"; Path = "07_Debloater_e_Privacidade"; Scripts = @("01_remover_xbox_apps.bat", "02_remover_cortana.bat", "03_remover_teams.bat", "04_remover_onedrive.bat") },
    @{ Name = "Limpeza"; Path = "08_Limpeza_e_Manutencao"; Scripts = @("08_limpeza_profunda.bat", "11_limpar_logs_eventos.bat", "13_remover_bloatware.bat") },
    @{ Name = "Inicialização"; Path = "09_Inicializacao_e_Servicos"; Scripts = @("01_desativar_superfetch.bat", "02_otimizar_servicos_jogos.bat", "03_otimizar_boot.bat", "04_desativar_apps_inicializacao.bat", "05_desativar_indexacao.bat", "06_desativar_spooler.bat", "07_desativar_windows_update.bat", "10_resetar_cache_update.bat", "14_desativar_apps_segundo_plano.bat") },
    @{ Name = "Jogos"; Path = "10_Otimizacoes_por_Jogo"; Scripts = @("01_otimizar_jogo_generico.bat", "02_otimizar_cs2.bat", "03_otimizar_fortnite.bat", "04_otimizar_valorant.bat", "05_otimizar_gta_v.bat", "06_otimizar_fivem.bat", "07_otimizar_roblox.bat", "08_otimizar_minecraft.bat", "09_otimizar_battlefield.bat", "10_otimizar_rdr2.bat") },
    @{ Name = "Reparo"; Path = "12_Reparo_e_Diagnostico"; Scripts = @("16_dism_restaurar_saude.bat", "17_sfc_scannow.bat", "18_agendar_chkdsk.bat", "19_atualizar_drivers_so.bat") }
)

# --- CRIAÇÃO DA JANELA PRINCIPAL --- #
$form = New-Object System.Windows.Forms.Form
$form.Text = "OTIMIZADOR DE PC REMOTO - GUI v1.1"
$form.Size = New-Object System.Drawing.Size(800, 600)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedSingle"
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")

# --- CONTROLE DE ABAS (TabControl) --- #
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Size = New-Object System.Drawing.Size(780, 400)
$tabControl.Location = New-Object System.Drawing.Point(10, 10)
$tabControl.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$tabControl.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
$tabControl.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($tabControl)

# --- ADICIONAR ABAS E CHECKBOXES --- #
$checkboxes = @{}

foreach ($category in $OptimizationCategories) {
    $tabPage = New-Object System.Windows.Forms.TabPage($category.Name)
    $tabPage.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#1a1a1a")
    $tabPage.AutoScroll = $true
    $tabControl.Controls.Add($tabPage)

    $yPos = 10
    foreach ($script in $category.Scripts) {
        $checkbox = New-Object System.Windows.Forms.CheckBox
        $checkbox.Text = $script
        $checkbox.Location = New-Object System.Drawing.Point(10, $yPos)
        $checkbox.AutoSize = $true
        $checkbox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
        $checkbox.Font = New-Object System.Drawing.Font("Segoe UI", 9)
        $tabPage.Controls.Add($checkbox)
        $checkboxes["$($category.Path)/$script"] = $checkbox
        $yPos += 25
    }
}

# --- BOTÃO EXECUTAR --- #
$btnExecute = New-Object System.Windows.Forms.Button
$btnExecute.Text = "Executar Otimizações"
$btnExecute.Location = New-Object System.Drawing.Point(10, 420)
$btnExecute.Size = New-Object System.Drawing.Size(150, 40)
$btnExecute.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#9933ff")
$btnExecute.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$btnExecute.FlatStyle = "Flat"
$btnExecute.FlatAppearance.BorderSize = 0
$btnExecute.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($btnExecute)

# --- LOG DE EXECUÇÃO --- #
$logTextBox = New-Object System.Windows.Forms.TextBox
$logTextBox.Multiline = $true
$logTextBox.ReadOnly = $true
$logTextBox.ScrollBars = "Vertical"
$logTextBox.Location = New-Object System.Drawing.Point(170, 420)
$logTextBox.Size = New-Object System.Drawing.Size(600, 130)
$logTextBox.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#1e1e1e")
$logTextBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#00ff00")
$logTextBox.Font = New-Object System.Drawing.Font("Consolas", 9)
$form.Controls.Add($logTextBox)

# --- EVENTO DO BOTÃO EXECUTAR --- #
$btnExecute.Add_Click({
    $logTextBox.Text = ""
    $logTextBox.AppendText("Iniciando otimizações...`r`n")

    foreach ($category in $OptimizationCategories) {
        foreach ($script in $category.Scripts) {
            $fullPath = "$($category.Path)/$script"
            if ($checkboxes[$fullPath].Checked) {
                $logTextBox.AppendText("  -> Executando: $script`r`n")
                $content = Get-RemoteScriptContent -RelativePath $fullPath
                if ($content) {
                    $extension = [System.IO.Path]::GetExtension($script).TrimStart(".")
                    Invoke-ScriptBlockFromContent -Content $content -Type $extension
                    $logTextBox.AppendText("     [OK]`r`n")
                } else {
                    $logTextBox.AppendText("     [FALHA] Nao foi possivel baixar o script.`r`n")
                }
            }
        }
    }
    $logTextBox.AppendText("`nOtimizações concluídas! Reinicie o computador.`r`n")
    [System.Windows.MessageBox]::Show("Otimizações concluídas! Reinicie o computador para aplicar todas as mudanças.", "Concluído", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
})

# --- EXIBIR A JANELA --- #
$form.ShowDialog()
