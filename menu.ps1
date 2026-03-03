# ==================================================================================================
# 🐺 LOBO ALPHA V2.0 - ULTRA CYBERPUNK EDITION
# ==================================================================================================
# Design Customizado | Cores: Lobo Tech Neon | Estilo: High-Performance GUI
# ==================================================================================================

# --- CONFIGURAÇÕES --- #
$RepoOwner = "lobaotech"
$RepoName = "otzremoto"
$Branch = "main"
$BaseUrl = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch"

# --- VERIFICAÇÃO DE ADMINISTRADOR --- #
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show("ACESSO NEGADO: Execute como Administrador para liberar o potencial do Lobo Alpha.", "Protocolo de Segurança", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    exit
}

# --- CARREGAR ASSEMBLIES --- #
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- PALETA CYBERPUNK (LOBO TECH) --- #
$Color_BG = [System.Drawing.ColorTranslator]::FromHtml("#050505")
$Color_Panel = [System.Drawing.ColorTranslator]::FromHtml("#0d0d0d")
$Color_Neon_Purple = [System.Drawing.ColorTranslator]::FromHtml("#9933ff")
$Color_Neon_Magenta = [System.Drawing.ColorTranslator]::FromHtml("#ff00ff")
$Color_Text_Main = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
$Color_Text_Dim = [System.Drawing.ColorTranslator]::FromHtml("#888888")
$Color_Log_BG = [System.Drawing.ColorTranslator]::FromHtml("#0a0a0a")
$Color_Log_Text = [System.Drawing.ColorTranslator]::FromHtml("#00ffcc")

$Font_Title = New-Object System.Drawing.Font("Segoe UI Semibold", 18)
$Font_Tab = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$Font_Check = New-Object System.Drawing.Font("Segoe UI", 9)
$Font_Log = New-Object System.Drawing.Font("Consolas", 9)

# --- FUNÇÕES DE EXECUÇÃO --- #
function Get-RemoteScript($Path) {
    $Url = "$BaseUrl/$($Path.Replace(" ", "%20"))"
    try { return (Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 10).Content } catch { return $null }
}

function Run-ScriptContent($Content, $Name) {
    if (-not $Content) { return "FALHA_DOWNLOAD" }
    $ext = [System.IO.Path]::GetExtension($Name).ToLower()
    $temp = Join-Path $env:TEMP "lobo_cyber_$($Name.Replace("/", "_"))"
    Set-Content -Path $temp -Value $Content -Encoding Ascii
    
    if ($ext -eq ".bat") {
        $p = Start-Process cmd.exe -ArgumentList "/c `"$temp`"" -PassThru -WindowStyle Hidden
        $p.WaitForExit()
    } elseif ($ext -eq ".reg") {
        $p = Start-Process reg.exe -ArgumentList "import `"$temp`"" -PassThru -WindowStyle Hidden
        $p.WaitForExit()
    }
    Remove-Item $temp -Force -ErrorAction SilentlyContinue
    return "EXECUTADO"
}

# --- JANELA PRINCIPAL --- #
$form = New-Object System.Windows.Forms.Form
$form.Text = "🐺 LOBO ALPHA V2.0 | CYBERPUNK INTERFACE"
$form.Size = New-Object System.Drawing.Size(1000, 750)
$form.BackColor = $Color_BG
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedSingle"
$form.MaximizeBox = $false

# --- HEADER NEON --- #
$pnlHeader = New-Object System.Windows.Forms.Panel
$pnlHeader.Size = New-Object System.Drawing.Size(1000, 100)
$pnlHeader.BackColor = $Color_Panel
$pnlHeader.BorderStyle = "None"
$form.Controls.Add($pnlHeader)

# Borda Neon no Header
$pnlHeader.Add_Paint({
    param($s, $e)
    $pen = New-Object System.Drawing.Pen($Color_Neon_Purple, 2)
    $e.Graphics.DrawLine($pen, 0, 98, 1000, 98)
})

$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "LOBO ALPHA V2.0 // DOMINE SEU HARDWARE"
$lblTitle.Font = $Font_Title
$lblTitle.ForeColor = $Color_Neon_Purple
$lblTitle.Location = New-Object System.Drawing.Point(40, 30)
$lblTitle.AutoSize = $true
$pnlHeader.Controls.Add($lblTitle)

# --- TAB CONTROL CUSTOMIZADO --- #
# Para evitar o visual cinza do Windows, vamos usar botões como abas
$pnlTabs = New-Object System.Windows.Forms.Panel
$pnlTabs.Location = New-Object System.Drawing.Point(40, 120)
$pnlTabs.Size = New-Object System.Drawing.Size(920, 40)
$form.Controls.Add($pnlTabs)

$pnlContent = New-Object System.Windows.Forms.Panel
$pnlContent.Location = New-Object System.Drawing.Point(40, 160)
$pnlContent.Size = New-Object System.Drawing.Size(920, 350)
$pnlContent.BackColor = $Color_Panel
$pnlContent.BorderStyle = "FixedSingle"
$form.Controls.Add($pnlContent)

# Borda Neon no Painel de Conteúdo
$pnlContent.Add_Paint({
    param($s, $e)
    $pen = New-Object System.Drawing.Pen($Color_Neon_Purple, 1)
    $e.Graphics.DrawRectangle($pen, 0, 0, $s.Width-1, $s.Height-1)
})

# --- DEFINIÇÃO DE CATEGORIAS --- #
$Modules = @(
    @{ Title = "PERFORMANCE"; Path = "02_Otimizacao_CPU_e_Energia"; Scripts = @("01_plano_desempenho_maximo.bat", "02_desbloquear_atributos_energia.bat", "06_desativar_core_parking.bat", "08_desativar_estrangulamento_energia.bat", "otimizacoes_energia.reg") },
    @{ Title = "GAMING"; Path = "10_Otimizacoes_por_Jogo"; Scripts = @("01_otimizar_jogo_generico.bat", "02_otimizar_cs2.bat", "03_otimizar_fortnite.bat", "04_otimizar_valorant.bat", "06_otimizar_fivem.bat") },
    @{ Title = "NETWORK"; Path = "04_Rede_e_DNS"; Scripts = @("01_reset_rede.bat", "10_limpar_dns.bat", "11_dns_cloudflare.bat", "otimizador_rede.bat") },
    @{ Title = "INPUT LAG"; Path = "05_Input_Lag_e_Perifericos"; Scripts = @("03_desativar_hpet.bat", "07_timer_resolution.bat", "08_aceleracao_mouse.bat", "otimizador_input_lag.bat") },
    @{ Title = "CLEANUP"; Path = "08_Limpeza_e_Manutencao"; Scripts = @("08_limpeza_profunda.bat", "11_limpar_logs_eventos.bat", "13_remover_bloatware.bat") },
    @{ Title = "SYSTEM"; Path = "07_Debloater_e_Privacidade"; Scripts = @("01_remover_xbox_apps.bat", "04_remover_onedrive.bat") }
)

$checks = @{}
$tabButtons = @()
$currentTab = $null

function Show-Tab($index) {
    $pnlContent.Controls.Clear()
    $m = $Modules[$index]
    
    $y = 20
    foreach ($s in $m.Scripts) {
        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Text = " > " + $s.ToUpper()
        $cb.ForeColor = $Color_Text_Main
        $cb.Font = $Font_Check
        $cb.Location = New-Object System.Drawing.Point(30, $y)
        $cb.AutoSize = $true
        $cb.FlatStyle = "Flat"
        $cb.FlatAppearance.CheckedBackColor = $Color_Neon_Purple
        $cb.FlatAppearance.BorderColor = $Color_Neon_Purple
        
        # Manter estado do checkbox
        $key = "$($m.Path)/$s"
        if ($checks.ContainsKey($key)) {
            $cb.Checked = $checks[$key].Checked
        }
        $checks[$key] = $cb
        
        $pnlContent.Controls.Add($cb)
        $y += 35
    }
    
    # Atualizar visual dos botões de aba
    for ($i=0; $i -lt $tabButtons.Count; $i++) {
        if ($i -eq $index) {
            $tabButtons[$i].BackColor = $Color_Neon_Purple
            $tabButtons[$i].ForeColor = $Color_Text_Main
        } else {
            $tabButtons[$i].BackColor = $Color_Panel
            $tabButtons[$i].ForeColor = $Color_Text_Dim
        }
    }
}

$tabX = 0
for ($i=0; $i -lt $Modules.Count; $i++) {
    $btnTab = New-Object System.Windows.Forms.Button
    $btnTab.Text = $Modules[$i].Title
    $btnTab.Size = New-Object System.Drawing.Size(120, 40)
    $btnTab.Location = New-Object System.Drawing.Point($tabX, 0)
    $btnTab.FlatStyle = "Flat"
    $btnTab.FlatAppearance.BorderSize = 1
    $btnTab.FlatAppearance.BorderColor = $Color_Neon_Purple
    $btnTab.Font = $Font_Tab
    $index = $i
    $btnTab.Add_Click({ Show-Tab $index })
    $pnlTabs.Controls.Add($btnTab)
    $tabButtons += $btnTab
    $tabX += 125
}

# Mostrar primeira aba por padrão
Show-Tab 0

# --- LOG CONSOLE --- #
$log = New-Object System.Windows.Forms.TextBox
$log.Multiline = $true
$log.ReadOnly = $true
$log.BackColor = $Color_Log_BG
$log.ForeColor = $Color_Log_Text
$log.Font = $Font_Log
$log.Location = New-Object System.Drawing.Point(40, 530)
$log.Size = New-Object System.Drawing.Size(680, 150)
$log.BorderStyle = "None"
$log.ScrollBars = "Vertical"
$form.Controls.Add($log)

# Borda Neon no Log
$logPanel = New-Object System.Windows.Forms.Panel
$logPanel.Location = New-Object System.Drawing.Point(39, 529)
$logPanel.Size = New-Object System.Drawing.Size(682, 152)
$logPanel.BackColor = $Color_Neon_Purple
$form.Controls.Add($logPanel)
$logPanel.SendToBack()

# --- BOTÕES DE AÇÃO --- #
$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Text = "APLICAR TWEAKS"
$btnRun.BackColor = $Color_Neon_Purple
$btnRun.ForeColor = $Color_Text_Main
$btnRun.FlatStyle = "Flat"
$btnRun.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$btnRun.Location = New-Object System.Drawing.Point(740, 530)
$btnRun.Size = New-Object System.Drawing.Size(220, 70)
$btnRun.FlatAppearance.BorderSize = 0
$form.Controls.Add($btnRun)

$btnRestore = New-Object System.Windows.Forms.Button
$btnRestore.Text = "RESTORE POINT"
$btnRestore.BackColor = $Color_Panel
$btnRestore.ForeColor = $Color_Neon_Magenta
$btnRestore.FlatStyle = "Flat"
$btnRestore.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnRestore.Location = New-Object System.Drawing.Point(740, 610)
$btnRestore.Size = New-Object System.Drawing.Size(220, 70)
$btnRestore.FlatAppearance.BorderColor = $Color_Neon_Magenta
$btnRestore.FlatAppearance.BorderSize = 2
$form.Controls.Add($btnRestore)

# --- LÓGICA DE EXECUÇÃO --- #
$btnRestore.Add_Click({
    $log.AppendText("[SYSTEM] Iniciando criação de Ponto de Restauração...`r`n")
    $c = Get-RemoteScript "01_Preparacao_e_Backup/01_CRIAR_PONTO_RESTAURACAO.bat"
    $res = Run-ScriptContent $c "01_CRIAR_PONTO_RESTAURACAO.bat"
    $log.AppendText("[SYSTEM] Status: $res`r`n")
})

$btnRun.Add_Click({
    $log.AppendText("`r`n[!] INICIANDO SEQUÊNCIA DE OTIMIZAÇÃO LOBO ALPHA...`r`n")
    $btnRun.Enabled = $false
    $btnRun.Text = "EXECUTANDO..."
    
    foreach ($key in $checks.Keys) {
        if ($checks[$key].Checked) {
            $log.AppendText("[FETCH] $key... ")
            $content = Get-RemoteScript $key
            if ($content) {
                $log.AppendText("RUNNING... ")
                $res = Run-ScriptContent $content $key
                $log.AppendText("[$res]`r`n")
            } else {
                $log.AppendText("[ERROR]`r`n")
            }
            $log.SelectionStart = $log.Text.Length
            $log.ScrollToCaret()
            [System.Windows.Forms.Application]::DoEvents()
        }
    }
    
    $log.AppendText("`r`n[✅] SEQUÊNCIA FINALIZADA. REINICIALIZAÇÃO RECOMENDADA.`r`n")
    $btnRun.Enabled = $true
    $btnRun.Text = "APLICAR TWEAKS"
    [System.Windows.Forms.MessageBox]::Show("Otimizações aplicadas com sucesso! Reinicie o computador para validar as alterações.", "Lobo Alpha V2.0", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

# --- EXIBIR --- #
$form.ShowDialog()
