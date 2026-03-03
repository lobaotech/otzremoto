# ==================================================================================================
# 🐺 LOBO ALPHA V2.0 - OTIMIZADOR PROFISSIONAL
# ==================================================================================================
# Inspirado no WinUtil do Chris Titus | Cores: Lobo Tech Brand
# ==================================================================================================

# --- CONFIGURAÇÕES --- #
$RepoOwner = "lobaotech"
$RepoName = "otzremoto"
$Branch = "main"
$BaseUrl = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch"

# --- VERIFICAÇÃO DE ADMINISTRADOR --- #
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show("Por favor, execute o PowerShell como Administrador para usar o Lobo Alpha V2.0.", "Acesso Negado", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    exit
}

# --- CARREGAR ASSEMBLIES --- #
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- ESTILO VISUAL (LOBO TECH) --- #
$Color_BG = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$Color_Panel = [System.Drawing.ColorTranslator]::FromHtml("#0a0a0a")
$Color_Accent = [System.Drawing.ColorTranslator]::FromHtml("#9933ff") # Roxo Lobo
$Color_Text = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
$Color_Log = [System.Drawing.ColorTranslator]::FromHtml("#1e1e1e")
$Font_Main = New-Object System.Drawing.Font("Segoe UI", 10)
$Font_Title = New-Object System.Drawing.Font("Segoe UI Semibold", 14)

# --- FUNÇÕES DE EXECUÇÃO --- #
function Get-RemoteScript($Path) {
    $Url = "$BaseUrl/$($Path.Replace(" ", "%20"))"
    try { return (Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 10).Content } catch { return $null }
}

function Run-ScriptContent($Content, $Name) {
    if (-not $Content) { return "Erro ao baixar $Name" }
    $ext = [System.IO.Path]::GetExtension($Name).ToLower()
    $temp = Join-Path $env:TEMP "lobo_temp_$($Name.Replace("/", "_"))"
    Set-Content -Path $temp -Value $Content -Encoding Ascii
    
    if ($ext -eq ".bat") {
        $p = Start-Process cmd.exe -ArgumentList "/c `"$temp`"" -PassThru -WindowStyle Hidden
        $p.WaitForExit()
    } elseif ($ext -eq ".reg") {
        $p = Start-Process reg.exe -ArgumentList "import `"$temp`"" -PassThru -WindowStyle Hidden
        $p.WaitForExit()
    }
    Remove-Item $temp -Force -ErrorAction SilentlyContinue
    return "OK"
}

# --- JANELA PRINCIPAL --- #
$form = New-Object System.Windows.Forms.Form
$form.Text = "🐺 LOBO ALPHA V2.0 | Domine seu Hardware"
$form.Size = New-Object System.Drawing.Size(900, 650)
$form.BackColor = $Color_BG
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedSingle"
$form.MaximizeBox = $false

# --- HEADER --- #
$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "LOBO ALPHA V2.0"
$lblTitle.Font = $Font_Title
$lblTitle.ForeColor = $Color_Accent
$lblTitle.Location = New-Object System.Drawing.Point(20, 15)
$lblTitle.AutoSize = $true
$form.Controls.Add($lblTitle)

# --- TAB CONTROL --- #
$tabs = New-Object System.Windows.Forms.TabControl
$tabs.Location = New-Object System.Drawing.Point(20, 60)
$tabs.Size = New-Object System.Drawing.Size(845, 400)
$tabs.BackColor = $Color_BG
$form.Controls.Add($tabs)

# --- DEFINIÇÃO DE CATEGORIAS --- #
$Modules = @(
    @{ Title = "🚀 Performance"; Path = "02_Otimizacao_CPU_e_Energia"; Scripts = @("01_plano_desempenho_maximo.bat", "02_desbloquear_atributos_energia.bat", "06_desativar_core_parking.bat", "08_desativar_estrangulamento_energia.bat", "otimizacoes_energia.reg") },
    @{ Title = "🎮 Gaming"; Path = "10_Otimizacoes_por_Jogo"; Scripts = @("01_otimizar_jogo_generico.bat", "02_otimizar_cs2.bat", "03_otimizar_fortnite.bat", "04_otimizar_valorant.bat", "06_otimizar_fivem.bat") },
    @{ Title = "🌐 Rede/DNS"; Path = "04_Rede_e_DNS"; Scripts = @("01_reset_rede.bat", "10_limpar_dns.bat", "11_dns_cloudflare.bat", "otimizador_rede.bat") },
    @{ Title = "🖱️ Input Lag"; Path = "05_Input_Lag_e_Perifericos"; Scripts = @("03_desativar_hpet.bat", "07_timer_resolution.bat", "08_aceleracao_mouse.bat", "otimizador_input_lag.bat") },
    @{ Title = "🧹 Limpeza"; Path = "08_Limpeza_e_Manutencao"; Scripts = @("08_limpeza_profunda.bat", "11_limpar_logs_eventos.bat", "13_remover_bloatware.bat") },
    @{ Title = "🛡️ Sistema"; Path = "07_Debloater_e_Privacidade"; Scripts = @("01_remover_xbox_apps.bat", "04_remover_onedrive.bat", "README.md") }
)

$checks = @{}

foreach ($m in $Modules) {
    $tp = New-Object System.Windows.Forms.TabPage($m.Title)
    $tp.BackColor = $Color_Panel
    $tabs.TabPages.Add($tp)
    
    $y = 15
    foreach ($s in $m.Scripts) {
        if ($s.EndsWith(".bat") -or $s.EndsWith(".reg")) {
            $cb = New-Object System.Windows.Forms.CheckBox
            $cb.Text = $s
            $cb.ForeColor = $Color_Text
            $cb.Location = New-Object System.Drawing.Point(20, $y)
            $cb.AutoSize = $true
            $tp.Controls.Add($cb)
            $checks["$($m.Path)/$s"] = $cb
            $y += 30
        }
    }
}

# --- LOG BOX --- #
$log = New-Object System.Windows.Forms.TextBox
$log.Multiline = $true
$log.ReadOnly = $true
$log.BackColor = $Color_Log
$log.ForeColor = [System.Drawing.Color]::LimeGreen
$log.Font = New-Object System.Drawing.Font("Consolas", 9)
$log.Location = New-Object System.Drawing.Point(20, 475)
$log.Size = New-Object System.Drawing.Size(650, 120)
$log.ScrollBars = "Vertical"
$form.Controls.Add($log)

# --- BOTÃO EXECUTAR --- #
$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Text = "APLICAR TWEAKS"
$btnRun.BackColor = $Color_Accent
$btnRun.ForeColor = $Color_Text
$btnRun.FlatStyle = "Flat"
$btnRun.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnRun.Location = New-Object System.Drawing.Point(685, 475)
$btnRun.Size = New-Object System.Drawing.Size(180, 50)
$form.Controls.Add($btnRun)

# --- BOTÃO RESTAURAR --- #
$btnRestore = New-Object System.Windows.Forms.Button
$btnRestore.Text = "CRIAR RESTORE POINT"
$btnRestore.BackColor = $Color_Panel
$btnRestore.ForeColor = $Color_Text
$btnRestore.FlatStyle = "Flat"
$btnRestore.Location = New-Object System.Drawing.Point(685, 545)
$btnRestore.Size = New-Object System.Drawing.Size(180, 50)
$form.Controls.Add($btnRestore)

# --- LÓGICA --- #
$btnRestore.Add_Click({
    $log.AppendText("[*] Criando Ponto de Restauração...`r`n")
    $c = Get-RemoteScript "01_Preparacao_e_Backup/01_CRIAR_PONTO_RESTAURACAO.bat"
    $res = Run-ScriptContent $c "01_CRIAR_PONTO_RESTAURACAO.bat"
    $log.AppendText("[+] Resultado: $res`r`n")
})

$btnRun.Add_Click({
    $log.AppendText("`r`n[!] Iniciando Otimização Lobo Alpha...`r`n")
    $btnRun.Enabled = $false
    
    foreach ($key in $checks.Keys) {
        if ($checks[$key].Checked) {
            $log.AppendText("[>] Baixando: $key... ")
            $content = Get-RemoteScript $key
            if ($content) {
                $log.AppendText("Executando... ")
                $res = Run-ScriptContent $content $key
                $log.AppendText("[$res]`r`n")
            } else {
                $log.AppendText("[ERRO]`r`n")
            }
            $log.SelectionStart = $log.Text.Length
            $log.ScrollToCaret()
            [System.Windows.Forms.Application]::DoEvents()
        }
    }
    
    $log.AppendText("`r`n[✅] PROCESSO CONCLUÍDO! REINICIE O PC.`r`n")
    $btnRun.Enabled = $true
    [System.Windows.Forms.MessageBox]::Show("Otimizações aplicadas com sucesso! Reinicie o computador para validar as alterações.", "Lobo Alpha V2.0", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

# --- EXIBIR --- #
$form.ShowDialog()
