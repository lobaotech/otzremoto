# ==================================================================================================
# 🐺 LOBO ALPHA V2.0 - CYBERPUNK EDITION
# ==================================================================================================
# Design Futurista | Cores: Lobo Tech Neon | Estilo: High-Performance
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
$Color_Log_Text = [System.Drawing.ColorTranslator]::FromHtml("#00ffcc") # Ciano Cyber

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
$form.Size = New-Object System.Drawing.Size(950, 700)
$form.BackColor = $Color_BG
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedSingle"
$form.MaximizeBox = $false

# --- HEADER NEON --- #
$pnlHeader = New-Object System.Windows.Forms.Panel
$pnlHeader.Size = New-Object System.Drawing.Size(950, 80)
$pnlHeader.BackColor = $Color_Panel
$form.Controls.Add($pnlHeader)

$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "LOBO ALPHA V2.0 // DOMINE SEU HARDWARE"
$lblTitle.Font = $Font_Title
$lblTitle.ForeColor = $Color_Neon_Purple
$lblTitle.Location = New-Object System.Drawing.Point(30, 20)
$lblTitle.AutoSize = $true
$pnlHeader.Controls.Add($lblTitle)

$lblSub = New-Object System.Windows.Forms.Label
$lblSub.Text = "PROTOCOL: PERFORMANCE_MAX // STATUS: READY"
$lblSub.Font = New-Object System.Drawing.Font("Segoe UI", 8)
$lblSub.ForeColor = $Color_Text_Dim
$lblSub.Location = New-Object System.Drawing.Point(32, 50)
$lblSub.AutoSize = $true
$pnlHeader.Controls.Add($lblSub)

# --- TAB CONTROL ESTILIZADO --- #
$tabs = New-Object System.Windows.Forms.TabControl
$tabs.Location = New-Object System.Drawing.Point(30, 100)
$tabs.Size = New-Object System.Drawing.Size(880, 400)
$tabs.BackColor = $Color_BG
$form.Controls.Add($tabs)

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

foreach ($m in $Modules) {
    $tp = New-Object System.Windows.Forms.TabPage($m.Title)
    $tp.BackColor = $Color_Panel
    $tabs.TabPages.Add($tp)
    
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
        $tp.Controls.Add($cb)
        $checks["$($m.Path)/$s"] = $cb
        $y += 35
    }
}

# --- LOG CONSOLE --- #
$log = New-Object System.Windows.Forms.TextBox
$log.Multiline = $true
$log.ReadOnly = $true
$log.BackColor = $Color_Log_BG
$log.ForeColor = $Color_Log_Text
$log.Font = $Font_Log
$log.Location = New-Object System.Drawing.Point(30, 520)
$log.Size = New-Object System.Drawing.Size(650, 120)
$log.BorderStyle = "None"
$log.ScrollBars = "Vertical"
$form.Controls.Add($log)

# --- BOTÕES DE AÇÃO --- #
$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Text = "APLICAR TWEAKS"
$btnRun.BackColor = $Color_Neon_Purple
$btnRun.ForeColor = $Color_Text_Main
$btnRun.FlatStyle = "Flat"
$btnRun.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$btnRun.Location = New-Object System.Drawing.Point(700, 520)
$btnRun.Size = New-Object System.Drawing.Size(210, 55)
$btnRun.FlatAppearance.BorderSize = 0
$form.Controls.Add($btnRun)

$btnRestore = New-Object System.Windows.Forms.Button
$btnRestore.Text = "RESTORE POINT"
$btnRestore.BackColor = $Color_Panel
$btnRestore.ForeColor = $Color_Neon_Magenta
$btnRestore.FlatStyle = "Flat"
$btnRestore.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$btnRestore.Location = New-Object System.Drawing.Point(700, 585)
$btnRestore.Size = New-Object System.Drawing.Size(210, 55)
$btnRestore.FlatAppearance.BorderColor = $Color_Neon_Magenta
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
