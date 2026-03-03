# ==================================================================================================
# 🐺 LOBO ALPHA V2.0 - PREMIUM CYBERPUNK EDITION (WEB-BRIDGE ENGINE)
# ==================================================================================================
# Interface: HTML5/CSS3/JS (Modern GUI) | Engine: PowerShell (Native Execution)
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

# --- DEFINIÇÃO DA INTERFACE HTML (CYBERPUNK DESIGN) --- #
$html = @"
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>LOBO ALPHA V2.0 // PREMIUM</title>
    <style>
        :root {
            --bg: #050505;
            --panel: #0d0d0d;
            --neon-purple: #9933ff;
            --neon-magenta: #ff00ff;
            --neon-cyan: #00ffcc;
            --text-main: #ffffff;
            --text-dim: #888888;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', 'Tahoma', sans-serif; }
        body { background: var(--bg); color: var(--text-main); overflow: hidden; height: 100vh; display: flex; flex-direction: column; border: 2px solid var(--neon-purple); }

        /* Header */
        header { padding: 25px 35px; background: var(--panel); border-bottom: 2px solid var(--neon-purple); box-shadow: 0 0 25px rgba(153, 51, 255, 0.4); display: flex; justify-content: space-between; align-items: center; }
        .logo-area h1 { font-size: 24px; color: var(--neon-purple); text-transform: uppercase; letter-spacing: 3px; text-shadow: 0 0 15px var(--neon-purple); }
        .logo-area p { font-size: 11px; color: var(--text-dim); margin-top: 5px; font-family: monospace; }

        /* Main Layout */
        main { flex: 1; display: flex; padding: 25px; gap: 25px; overflow: hidden; }
        .content-area { flex: 1; display: flex; flex-direction: column; gap: 20px; }

        /* Tabs */
        .tabs { display: flex; gap: 8px; }
        .tab-btn { padding: 12px 20px; background: rgba(153, 51, 255, 0.05); border: 1px solid var(--neon-purple); color: var(--text-dim); cursor: pointer; font-weight: bold; transition: 0.3s; text-transform: uppercase; font-size: 12px; border-radius: 4px; }
        .tab-btn.active { background: var(--neon-purple); color: var(--text-main); box-shadow: 0 0 20px var(--neon-purple); border-color: var(--neon-magenta); }
        .tab-btn:hover { border-color: var(--neon-magenta); color: var(--text-main); background: rgba(153, 51, 255, 0.15); }

        /* Scripts List */
        .scripts-container { flex: 1; background: var(--panel); border: 1px solid rgba(153, 51, 255, 0.3); padding: 20px; overflow-y: auto; border-radius: 5px; box-shadow: inset 0 0 15px rgba(0,0,0,0.5); }
        .script-item { display: flex; align-items: center; gap: 12px; padding: 10px; border-bottom: 1px solid rgba(255, 255, 255, 0.03); transition: 0.2s; cursor: pointer; }
        .script-item:hover { background: rgba(153, 51, 255, 0.08); border-left: 3px solid var(--neon-purple); }
        .script-item input[type="checkbox"] { width: 18px; height: 18px; cursor: pointer; accent-color: var(--neon-purple); }
        .script-item label { cursor: pointer; font-size: 14px; letter-spacing: 0.8px; color: var(--text-main); }

        /* Sidebar Actions */
        .sidebar { width: 260px; display: flex; flex-direction: column; gap: 20px; }
        .action-btn { padding: 20px; border: none; cursor: pointer; font-weight: bold; font-size: 15px; text-transform: uppercase; transition: 0.4s; border-radius: 5px; position: relative; overflow: hidden; }
        
        .btn-apply { background: linear-gradient(45deg, var(--neon-purple), var(--neon-magenta)); color: white; box-shadow: 0 0 25px rgba(153, 51, 255, 0.6); border: 1px solid rgba(255,255,255,0.2); }
        .btn-apply:hover { transform: translateY(-2px); box-shadow: 0 0 35px rgba(153, 51, 255, 0.8); filter: brightness(1.1); }
        
        .btn-restore { background: transparent; border: 2px solid var(--neon-magenta); color: var(--neon-magenta); box-shadow: 0 0 10px rgba(255, 0, 255, 0.2); }
        .btn-restore:hover { background: rgba(255, 0, 255, 0.1); box-shadow: 0 0 20px var(--neon-magenta); color: white; }

        /* Log Console */
        .console { height: 160px; background: #000; border: 1px solid var(--neon-cyan); padding: 15px; font-family: 'Consolas', monospace; font-size: 12px; color: var(--neon-cyan); overflow-y: auto; border-radius: 4px; box-shadow: inset 0 0 10px rgba(0, 255, 204, 0.1); }
        .log-entry { margin-bottom: 4px; border-left: 2px solid var(--neon-cyan); padding-left: 8px; }

        /* Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: var(--bg); }
        ::-webkit-scrollbar-thumb { background: var(--neon-purple); border-radius: 10px; }
    </style>
</head>
<body>
    <header>
        <div class="logo-area">
            <h1>🐺 LOBO ALPHA V2.0 // PREMIUM</h1>
            <p>PROTOCOL: PERFORMANCE_MAX // STATUS: SYSTEM_READY // USER: ADMIN</p>
        </div>
        <div style="text-align: right;">
            <span style="color: var(--neon-cyan); font-size: 10px; font-family: monospace;">ENCRYPTED_CONNECTION: TRUE</span>
        </div>
    </header>

    <main>
        <div class="content-area">
            <div class="tabs" id="tabList"></div>
            <div class="scripts-container" id="scriptList"></div>
            <div class="console" id="consoleLog">
                <div class="log-entry">[SYSTEM] Lobo Alpha V2.0 Premium Initialized...</div>
                <div class="log-entry">[SYSTEM] Ready to dominate hardware.</div>
            </div>
        </div>

        <div class="sidebar">
            <button class="action-btn btn-apply" onclick="runOptimization()">APLICAR TWEAKS</button>
            <button class="action-btn btn-restore" onclick="createRestorePoint()">RESTORE POINT</button>
            <div style="margin-top: auto; padding: 20px; background: rgba(153, 51, 255, 0.05); border-radius: 5px; border-left: 4px solid var(--neon-purple); border-right: 1px solid rgba(153, 51, 255, 0.2);">
                <p style="font-size: 11px; color: var(--text-dim); line-height: 1.6; text-align: center;">
                    <strong style="color: var(--neon-purple);">LOBO TECH PREMIUM</strong><br>
                    Otimização avançada para máxima performance em jogos e produtividade.
                </p>
            </div>
        </div>
    </main>

    <script>
        const modules = [
            { title: "PERFORMANCE", path: "02_Otimizacao_CPU_e_Energia", scripts: ["01_plano_desempenho_maximo.bat", "02_desbloquear_atributos_energia.bat", "06_desativar_core_parking.bat", "08_desativar_estrangulamento_energia.bat", "otimizacoes_energia.reg"] },
            { title: "GAMING", path: "10_Otimizacoes_por_Jogo", scripts: ["01_otimizar_jogo_generico.bat", "02_otimizar_cs2.bat", "03_otimizar_fortnite.bat", "04_otimizar_valorant.bat", "06_otimizar_fivem.bat"] },
            { title: "NETWORK", path: "04_Rede_e_DNS", scripts: ["01_reset_rede.bat", "10_limpar_dns.bat", "11_dns_cloudflare.bat", "otimizador_rede.bat"] },
            { title: "INPUT LAG", path: "05_Input_Lag_e_Perifericos", scripts: ["03_desativar_hpet.bat", "07_timer_resolution.bat", "08_aceleracao_mouse.bat", "otimizador_input_lag.bat"] },
            { title: "CLEANUP", path: "08_Limpeza_e_Manutencao", scripts: ["08_limpeza_profunda.bat", "11_limpar_logs_eventos.bat", "13_remover_bloatware.bat"] },
            { title: "SYSTEM", path: "07_Debloater_e_Privacidade", scripts: ["01_remover_xbox_apps.bat", "04_remover_onedrive.bat"] }
        ];

        let selectedScripts = new Set();

        function init() {
            const tabList = document.getElementById('tabList');
            modules.forEach((m, index) => {
                const btn = document.createElement('button');
                btn.className = 'tab-btn' + (index === 0 ? ' active' : '');
                btn.innerText = m.title;
                btn.onclick = () => switchTab(index);
                tabList.appendChild(btn);
            });
            renderScripts(0);
        }

        function switchTab(index) {
            document.querySelectorAll('.tab-btn').forEach((btn, i) => {
                btn.className = 'tab-btn' + (i === index ? ' active' : '');
            });
            renderScripts(index);
        }

        function renderScripts(index) {
            const container = document.getElementById('scriptList');
            container.innerHTML = '';
            const m = modules[index];
            m.scripts.forEach(s => {
                const key = m.path + "/" + s;
                const item = document.createElement('div');
                item.className = 'script-item';
                item.innerHTML = '<input type="checkbox" id="'+key+'" '+(selectedScripts.has(key) ? 'checked' : '')+' onchange="toggleScript(\''+key+'\')"><label for="'+key+'">> '+s.toUpperCase()+'</label>';
                item.onclick = (e) => { if(e.target.tagName !== 'INPUT') { const cb = item.querySelector('input'); cb.checked = !cb.checked; toggleScript(key); } };
                container.appendChild(item);
            });
        }

        function toggleScript(key) {
            if (selectedScripts.has(key)) selectedScripts.delete(key);
            else selectedScripts.add(key);
        }

        function runOptimization() {
            if (selectedScripts.size === 0) { alert("Selecione ao menos um tweak."); return; }
            const scripts = Array.from(selectedScripts).join('|');
            window.location.href = "cmd:RUN:" + scripts;
        }

        function createRestorePoint() {
            window.location.href = "cmd:RESTORE";
        }

        init();
    </script>
</body>
</html>
"@

# --- LÓGICA DE EXECUÇÃO POWERSHELL (WEB-BRIDGE) --- #
$tempHtml = Join-Path $env:TEMP "lobo_alpha_premium.html"
[System.IO.File]::WriteAllText($tempHtml, $html, [System.Text.Encoding]::UTF8)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Forçar IE11 para renderizar CSS moderno
$regPath = "HKCU:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION"
if (-not (Test-Path $regPath)) { New-Item $regPath -Force | Out-Null }
New-ItemProperty -Path $regPath -Name "powershell.exe" -Value 11001 -PropertyType DWORD -Force | Out-Null

$form = New-Object System.Windows.Forms.Form
$form.Text = "🐺 LOBO ALPHA V2.0 PREMIUM"
$form.Size = New-Object System.Drawing.Size(1050, 780)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::Black
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$browser = New-Object System.Windows.Forms.WebBrowser
$browser.Dock = "Fill"
$browser.ScriptErrorsSuppressed = $true
$browser.Url = "file://$tempHtml"

# Ponte de Comando (Intercepta cliques na Web e executa no Windows)
$browser.Add_Navigating({
    param($s, $e)
    $url = $e.Url.OriginalString
    if ($url.StartsWith("cmd:")) {
        $e.Cancel = $true
        $data = $url.Substring(4)
        
        if ($data.StartsWith("RUN:")) {
            $scripts = $data.Substring(4).Split("|")
            foreach ($s in $scripts) {
                Write-Host "[EXECUTANDO] $s" -ForegroundColor Cyan
                $downloadUrl = "$BaseUrl/$($s.Replace(" ", "%20"))"
                try {
                    $content = (Invoke-WebRequest -Uri $downloadUrl -UseBasicParsing).Content
                    $tempFile = Join-Path $env:TEMP "lobo_run_$($s.Replace("/", "_"))"
                    [System.IO.File]::WriteAllText($tempFile, $content, [System.Text.Encoding]::UTF8)
                    if ($s.EndsWith(".bat")) { Start-Process cmd.exe -ArgumentList "/c `"$tempFile`"" -Wait -WindowStyle Hidden }
                    elseif ($s.EndsWith(".reg")) { Start-Process reg.exe -ArgumentList "import `"$tempFile`"" -Wait -WindowStyle Hidden }
                    Remove-Item $tempFile -Force
                } catch { Write-Host "[ERRO] Falha ao baixar $s" -ForegroundColor Red }
            }
            [System.Windows.Forms.MessageBox]::Show("Otimizações concluídas com sucesso!", "Lobo Alpha Premium")
        } elseif ($data -eq "RESTORE") {
            Write-Host "[RESTORE] Criando ponto de restauração..." -ForegroundColor Magenta
            $downloadUrl = "$BaseUrl/01_Preparacao_e_Backup/01_CRIAR_PONTO_RESTAURACAO.bat"
            $content = (Invoke-WebRequest -Uri $downloadUrl -UseBasicParsing).Content
            $tempFile = Join-Path $env:TEMP "lobo_restore.bat"
            [System.IO.File]::WriteAllText($tempFile, $content, [System.Text.Encoding]::UTF8)
            Start-Process cmd.exe -ArgumentList "/c `"$tempFile`"" -Wait -WindowStyle Hidden
            Remove-Item $tempFile -Force
            [System.Windows.Forms.MessageBox]::Show("Ponto de restauração criado!", "Lobo Alpha Premium")
        }
    }
})

$form.Controls.Add($browser)
$form.Add_FormClosing({ Remove-Item $tempHtml -Force -ErrorAction SilentlyContinue })
$form.ShowDialog()
