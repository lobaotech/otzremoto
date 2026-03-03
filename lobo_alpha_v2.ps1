# ==================================================================================================
# 🐺 LOBO ALPHA V2.0 - ULTRA PREMIUM CYBERPUNK EDITION (GDI+ ENGINE)
# ==================================================================================================
# Desenvolvido para: Lobo Tech | Estilo: Cyberpunk High-Performance
# ==================================================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- CONFIGURAÇÕES --- #
$RepoOwner = "lobaotech"
$RepoName = "otzremoto"
$Branch = "main"
$BaseUrl = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch"

# --- VERIFICAÇÃO DE ADMINISTRADOR --- #
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("ACESSO NEGADO: Execute como Administrador para liberar o potencial do Lobo Alpha.", "Protocolo de Segurança", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    exit
}

# --- DEFINIÇÃO DE CORES E ESTILOS --- #
$ColorBg = [System.Drawing.Color]::FromArgb(5, 5, 5)
$ColorPanel = [System.Drawing.Color]::FromArgb(15, 15, 15)
$ColorNeonPurple = [System.Drawing.Color]::FromArgb(153, 51, 255)
$ColorNeonMagenta = [System.Drawing.Color]::FromArgb(255, 0, 255)
$ColorNeonCyan = [System.Drawing.Color]::FromArgb(0, 255, 204)
$ColorTextMain = [System.Drawing.Color]::White
$ColorTextDim = [System.Drawing.Color]::FromArgb(150, 150, 150)

# --- ESTRUTURA DE DADOS --- #
$Modules = @(
    @{ Title = "PERFORMANCE"; Path = "02_Otimizacao_CPU_e_Energia"; Scripts = @("01_plano_desempenho_maximo.bat", "02_desbloquear_atributos_energia.bat", "06_desativar_core_parking.bat", "08_desativar_estrangulamento_energia.bat", "otimizacoes_energia.reg") },
    @{ Title = "GAMING"; Path = "10_Otimizacoes_por_Jogo"; Scripts = @("01_otimizar_jogo_generico.bat", "02_otimizar_cs2.bat", "03_otimizar_fortnite.bat", "04_otimizar_valorant.bat", "06_otimizar_fivem.bat") },
    @{ Title = "NETWORK"; Path = "04_Rede_e_DNS"; Scripts = @("01_reset_rede.bat", "10_limpar_dns.bat", "11_dns_cloudflare.bat", "otimizador_rede.bat") },
    @{ Title = "INPUT LAG"; Path = "05_Input_Lag_e_Perifericos"; Scripts = @("03_desativar_hpet.bat", "07_timer_resolution.bat", "08_aceleracao_mouse.bat", "otimizador_input_lag.bat") },
    @{ Title = "CLEANUP"; Path = "08_Limpeza_e_Manutencao"; Scripts = @("08_limpeza_profunda.bat", "11_limpar_logs_eventos.bat", "13_remover_bloatware.bat") },
    @{ Title = "SYSTEM"; Path = "07_Debloater_e_Privacidade"; Scripts = @("01_remover_xbox_apps.bat", "04_remover_onedrive.bat") }
)

$SelectedScripts = New-Object System.Collections.Generic.HashSet[string]
$CurrentModuleIndex = 0

# --- CRIAÇÃO DO FORMULÁRIO --- #
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "LOBO ALPHA V2.0 // DOMINE SEU HARDWARE"
$Form.Size = New-Object System.Drawing.Size(1000, 700)
$Form.StartPosition = "CenterScreen"
$Form.BackColor = $ColorBg
$Form.FormBorderStyle = "FixedSingle"
$Form.MaximizeBox = $false

# --- HEADER --- #
$HeaderPanel = New-Object System.Windows.Forms.Panel
$HeaderPanel.Size = New-Object System.Drawing.Size(1000, 80)
$HeaderPanel.Dock = "Top"
$HeaderPanel.BackColor = $ColorPanel
$HeaderPanel.Paint += {
    param($s, $e)
    $g = $e.Graphics
    $pen = New-Object System.Drawing.Pen($ColorNeonPurple, 2)
    $g.DrawLine($pen, 0, 78, 1000, 78)
}

$TitleLabel = New-Object System.Windows.Forms.Label
$TitleLabel.Text = "LOBO ALPHA V2.0 // DOMINE SEU HARDWARE"
$TitleLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 20)
$TitleLabel.ForeColor = $ColorNeonPurple
$TitleLabel.Location = New-Object System.Drawing.Point(30, 20)
$TitleLabel.AutoSize = $true
$HeaderPanel.Controls.Add($TitleLabel)

# --- TABS PANEL --- #
$TabsPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$TabsPanel.Location = New-Object System.Drawing.Point(30, 100)
$TabsPanel.Size = New-Object System.Drawing.Size(700, 50)
$TabsPanel.BackColor = [System.Drawing.Color]::Transparent

# --- SCRIPTS LIST --- #
$ScriptsPanel = New-Object System.Windows.Forms.Panel
$ScriptsPanel.Location = New-Object System.Drawing.Point(30, 160)
$ScriptsPanel.Size = New-Object System.Drawing.Size(650, 350)
$ScriptsPanel.BackColor = $ColorPanel
$ScriptsPanel.BorderStyle = "FixedSingle"

$ScriptsList = New-Object System.Windows.Forms.CheckedListBox
$ScriptsList.Dock = "Fill"
$ScriptsList.BackColor = $ColorPanel
$ScriptsList.ForeColor = $ColorTextMain
$ScriptsList.Font = New-Object System.Drawing.Font("Consolas", 11)
$ScriptsList.BorderStyle = "None"
$ScriptsList.CheckOnClick = $true
$ScriptsPanel.Controls.Add($ScriptsList)

# --- CONSOLE LOG --- #
$ConsoleLog = New-Object System.Windows.Forms.RichTextBox
$ConsoleLog.Location = New-Object System.Drawing.Point(30, 530)
$ConsoleLog.Size = New-Object System.Drawing.Size(650, 120)
$ConsoleLog.BackColor = [System.Drawing.Color]::Black
$ConsoleLog.ForeColor = $ColorNeonCyan
$ConsoleLog.Font = New-Object System.Drawing.Font("Consolas", 10)
$ConsoleLog.ReadOnly = $true
$ConsoleLog.BorderStyle = "FixedSingle"

function Log($msg) {
    $timestamp = Get-Date -Format "HH:mm:ss"
    $ConsoleLog.AppendText("[$timestamp] $msg`n")
    $ConsoleLog.ScrollToCaret()
}

# --- SIDEBAR ACTIONS --- #
$BtnApply = New-Object System.Windows.Forms.Button
$BtnApply.Text = "APLICAR TWEAKS"
$BtnApply.Location = New-Object System.Drawing.Point(710, 160)
$BtnApply.Size = New-Object System.Drawing.Size(250, 80)
$BtnApply.BackColor = $ColorNeonPurple
$BtnApply.ForeColor = [System.Drawing.Color]::White
$BtnApply.FlatStyle = "Flat"
$BtnApply.Font = New-Object System.Drawing.Font("Segoe UI Bold", 14)
$BtnApply.FlatAppearance.BorderSize = 0

$BtnRestore = New-Object System.Windows.Forms.Button
$BtnRestore.Text = "RESTORE POINT"
$BtnRestore.Location = New-Object System.Drawing.Point(710, 260)
$BtnRestore.Size = New-Object System.Drawing.Size(250, 60)
$BtnRestore.BackColor = [System.Drawing.Color]::Transparent
$BtnRestore.ForeColor = $ColorNeonMagenta
$BtnRestore.FlatStyle = "Flat"
$BtnRestore.Font = New-Object System.Drawing.Font("Segoe UI Bold", 12)
$BtnRestore.FlatAppearance.BorderColor = $ColorNeonMagenta
$BtnRestore.FlatAppearance.BorderSize = 2

# --- LÓGICA DE ABAS --- #
function UpdateScriptsList($index) {
    $ScriptsList.Items.Clear()
    $module = $Modules[$index]
    foreach ($s in $module.Scripts) {
        $ScriptsList.Items.Add("> " + $s.ToUpper())
    }
}

foreach ($i in 0..($Modules.Count - 1)) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $Modules[$i].Title
    $btn.Size = New-Object System.Drawing.Size(110, 40)
    $btn.FlatStyle = "Flat"
    $btn.ForeColor = $ColorTextDim
    $btn.FlatAppearance.BorderColor = $ColorNeonPurple
    $btn.Tag = $i
    $btn.Add_Click({
        param($s, $e)
        $global:CurrentModuleIndex = $s.Tag
        UpdateScriptsList($s.Tag)
        foreach ($b in $TabsPanel.Controls) { $b.BackColor = [System.Drawing.Color]::Transparent; $b.ForeColor = $ColorTextDim }
        $s.BackColor = $ColorNeonPurple
        $s.ForeColor = [System.Drawing.Color]::White
    })
    if ($i -eq 0) { $btn.BackColor = $ColorNeonPurple; $btn.ForeColor = [System.Drawing.Color]::White }
    $TabsPanel.Controls.Add($btn)
}

# --- EXECUÇÃO --- #
$BtnApply.Add_Click({
    if ($ScriptsList.CheckedItems.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Selecione ao menos um tweak para aplicar.", "Lobo Alpha")
        return
    }
    
    Log("Iniciando otimização selecionada...")
    $module = $Modules[$global:CurrentModuleIndex]
    foreach ($item in $ScriptsList.CheckedItems) {
        $scriptName = $item.Substring(2).ToLower()
        Log("Baixando e executando: $scriptName")
        
        $url = "$BaseUrl/$($module.Path)/$($scriptName.Replace(" ", "%20"))"
        try {
            $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content
            $tempFile = Join-Path $env:TEMP "lobo_run_$($scriptName.Replace("/", "_"))"
            [System.IO.File]::WriteAllText($tempFile, $content, [System.Text.Encoding]::UTF8)
            
            if ($scriptName.EndsWith(".bat")) { Start-Process cmd.exe -ArgumentList "/c `"$tempFile`"" -Wait -WindowStyle Hidden }
            elseif ($scriptName.EndsWith(".reg")) { Start-Process reg.exe -ArgumentList "import `"$tempFile`"" -Wait -WindowStyle Hidden }
            
            Remove-Item $tempFile -Force
            Log("Sucesso: $scriptName")
        } catch {
            Log("ERRO: Falha ao processar $scriptName")
        }
    }
    [System.Windows.Forms.MessageBox]::Show("Otimizações concluídas!", "Lobo Alpha")
})

$BtnRestore.Add_Click({
    Log("Criando ponto de restauração...")
    $url = "$BaseUrl/01_Preparacao_e_Backup/01_CRIAR_PONTO_RESTAURACAO.bat"
    try {
        $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content
        $tempFile = Join-Path $env:TEMP "lobo_restore.bat"
        [System.IO.File]::WriteAllText($tempFile, $content, [System.Text.Encoding]::UTF8)
        Start-Process cmd.exe -ArgumentList "/c `"$tempFile`"" -Wait -WindowStyle Hidden
        Remove-Item $tempFile -Force
        Log("Ponto de restauração criado com sucesso.")
        [System.Windows.Forms.MessageBox]::Show("Ponto de restauração criado!", "Lobo Alpha")
    } catch {
        Log("ERRO: Falha ao criar ponto de restauração.")
    }
})

# --- INICIALIZAÇÃO --- #
$Form.Controls.Add($HeaderPanel)
$Form.Controls.Add($TabsPanel)
$Form.Controls.Add($ScriptsPanel)
$Form.Controls.Add($ConsoleLog)
$Form.Controls.Add($BtnApply)
$Form.Controls.Add($BtnRestore)

UpdateScriptsList(0)
Log("Lobo Alpha V2.0 Premium carregado.")
Log("Aguardando seleção do usuário...")

$Form.ShowDialog()
