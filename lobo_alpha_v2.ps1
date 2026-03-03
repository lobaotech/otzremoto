# ==================================================================================================
# 🐺 LOBO ALPHA V2.0 - PREMIUM CYBERPUNK EDITION
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

# --- DEFINIÇÃO DA INTERFACE HTML --- #
$html = @"
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background: var(--bg); color: var(--text-main); overflow: hidden; height: 100vh; display: flex; flex-direction: column; }

        /* Header */
        header { padding: 30px 40px; background: var(--panel); border-bottom: 2px solid var(--neon-purple); box-shadow: 0 0 20px rgba(153, 51, 255, 0.3); }
        h1 { font-size: 24px; color: var(--neon-purple); text-transform: uppercase; letter-spacing: 2px; text-shadow: 0 0 10px var(--neon-purple); }
        p.status { font-size: 12px; color: var(--text-dim); margin-top: 5px; font-family: monospace; }

        /* Main Layout */
        main { flex: 1; display: flex; padding: 30px; gap: 30px; overflow: hidden; }
        .content-area { flex: 1; display: flex; flex-direction: column; gap: 20px; }

        /* Tabs */
        .tabs { display: flex; gap: 10px; }
        .tab-btn { padding: 12px 25px; background: var(--panel); border: 1px solid var(--neon-purple); color: var(--text-dim); cursor: pointer; font-weight: bold; transition: 0.3s; text-transform: uppercase; font-size: 13px; }
        .tab-btn.active { background: var(--neon-purple); color: var(--text-main); box-shadow: 0 0 15px var(--neon-purple); }
        .tab-btn:hover { border-color: var(--neon-magenta); color: var(--text-main); }

        /* Scripts List */
        .scripts-container { flex: 1; background: var(--panel); border: 1px solid rgba(153, 51, 255, 0.5); padding: 25px; overflow-y: auto; border-radius: 5px; }
        .script-item { display: flex; align-items: center; gap: 15px; padding: 12px; border-bottom: 1px solid rgba(255, 255, 255, 0.05); transition: 0.2s; cursor: pointer; }
        .script-item:hover { background: rgba(153, 51, 255, 0.1); }
        .script-item input[type="checkbox"] { width: 18px; height: 18px; accent-color: var(--neon-purple); cursor: pointer; }
        .script-item label { cursor: pointer; font-size: 14px; letter-spacing: 0.5px; }

        /* Sidebar Actions */
        .sidebar { width: 280px; display: flex; flex-direction: column; gap: 20px; }
        .action-btn { padding: 20px; border: none; cursor: pointer; font-weight: bold; font-size: 16px; text-transform: uppercase; transition: 0.3s; border-radius: 4px; }
        .btn-apply { background: var(--neon-purple); color: white; box-shadow: 0 0 20px rgba(153, 51, 255, 0.5); }
        .btn-apply:hover { background: #b366ff; transform: scale(1.02); }
        .btn-restore { background: transparent; border: 2px solid var(--neon-magenta); color: var(--neon-magenta); }
        .btn-restore:hover { background: rgba(255, 0, 255, 0.1); box-shadow: 0 0 15px var(--neon-magenta); }

        /* Log Console */
        .console { height: 180px; background: #000; border: 1px solid var(--neon-cyan); padding: 15px; font-family: 'Consolas', monospace; font-size: 13px; color: var(--neon-cyan); overflow-y: auto; box-shadow: inset 0 0 10px rgba(0, 255, 204, 0.2); }
        .log-entry { margin-bottom: 5px; }
        .log-entry.success { color: #00ff00; }
        .log-entry.error { color: #ff3333; }

        /* Scrollbar */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: var(--bg); }
        ::-webkit-scrollbar-thumb { background: var(--neon-purple); border-radius: 10px; }
    </style>
</head>
<body>
    <header>
        <h1>🐺 LOBO ALPHA V2.0 // PREMIUM EDITION</h1>
        <p class="status">PROTOCOL: PERFORMANCE_MAX // STATUS: SYSTEM_READY // USER: ADMIN</p>
    </header>

    <main>
        <div class="content-area">
            <div class="tabs" id="tabList">
                <!-- Tabs will be injected here -->
            </div>
            <div class="scripts-container" id="scriptList">
                <!-- Scripts will be injected here -->
            </div>
            <div class="console" id="consoleLog">
                <div class="log-entry">[SYSTEM] Lobo Alpha V2.0 Initialized...</div>
                <div class="log-entry">[SYSTEM] Ready to dominate hardware.</div>
            </div>
        </div>

        <div class="sidebar">
            <button class="action-btn btn-apply" onclick="runOptimization()">APLICAR TWEAKS</button>
            <button class="action-btn btn-restore" onclick="createRestorePoint()">RESTORE POINT</button>
            <div style="margin-top: auto; padding: 20px; background: rgba(153, 51, 255, 0.05); border-radius: 5px; border-left: 3px solid var(--neon-purple);">
                <p style="font-size: 11px; color: var(--text-dim); line-height: 1.6;">
                    <strong>LOBO TECH PREMIUM</strong><br>
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
        let currentTabIndex = 0;

        function init() {
            const tabList = document.getElementById('tabList');
            modules.forEach((m, index) => {
                const btn = document.createElement('button');
                btn.className = `tab-btn ${index === 0 ? 'active' : ''}`;
                btn.innerText = m.title;
                btn.onclick = () => switchTab(index);
                tabList.appendChild(btn);
            });
            renderScripts(0);
        }

        function switchTab(index) {
            currentTabIndex = index;
            document.querySelectorAll('.tab-btn').forEach((btn, i) => {
                btn.className = `tab-btn ${i === index ? 'active' : ''}`;
            });
            renderScripts(index);
        }

        function renderScripts(index) {
            const container = document.getElementById('scriptList');
            container.innerHTML = '';
            const m = modules[index];
            m.scripts.forEach(s => {
                const key = `${m.path}/${s}`;
                const item = document.createElement('div');
                item.className = 'script-item';
                item.innerHTML = `
                    <input type="checkbox" id="${key}" ${selectedScripts.has(key) ? 'checked' : ''} onchange="toggleScript('${key}')">
                    <label for="${key}">> ${s.toUpperCase()}</label>
                `;
                item.onclick = (e) => {
                    if(e.target.tagName !== 'INPUT') {
                        const cb = item.querySelector('input');
                        cb.checked = !cb.checked;
                        toggleScript(key);
                    }
                };
                container.appendChild(item);
            });
        }

        function toggleScript(key) {
            if (selectedScripts.has(key)) selectedScripts.delete(key);
            else selectedScripts.add(key);
        }

        function log(msg, type = '') {
            const consoleLog = document.getElementById('consoleLog');
            const entry = document.createElement('div');
            entry.className = `log-entry ${type}`;
            entry.innerText = `[${new Date().toLocaleTimeString()}] ${msg}`;
            consoleLog.appendChild(entry);
            consoleLog.scrollTop = consoleLog.scrollHeight;
        }

        function runOptimization() {
            if (selectedScripts.size === 0) {
                alert("Selecione ao menos um tweak para aplicar.");
                return;
            }
            const scripts = Array.from(selectedScripts).join('|');
            window.external.notify("RUN:" + scripts);
        }

        function createRestorePoint() {
            window.external.notify("RESTORE");
        }

        init();
    </script>
</body>
</html>
"@

# --- LÓGICA DE EXECUÇÃO POWERSHELL --- #
$tempHtml = Join-Path $env:TEMP "lobo_alpha_gui.html"
Set-Content -Path $tempHtml -Value $html -Encoding UTF8

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "🐺 LOBO ALPHA V2.0 PREMIUM"
$form.Size = New-Object System.Drawing.Size(1000, 750)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::Black

$browser = New-Object System.Windows.Forms.WebBrowser
$browser.Dock = "Fill"
$browser.IsWebBrowserContextMenuEnabled = $false
$browser.AllowWebBrowserDrop = $false
$browser.ScriptErrorsSuppressed = $true
$browser.Url = "file://$tempHtml"

# Callback da Interface para o PowerShell
$browser.Add_ScriptErrorsSuppressed = $true
$browser.Add_Navigating({
    param($s, $e)
    if ($e.Url.OriginalString.StartsWith("javascript:")) { return }
    
    # Captura notificações do JS via window.external.notify
    # Nota: Em WinForms WebBrowser, usamos um truque de URL ou ObjectForScripting
})

# Usando ObjectForScripting para comunicação real
$scriptObject = New-Object -TypeName PSObject
$scriptObject | Add-Member -MemberType ScriptMethod -Name "notify" -Value {
    param($data)
    if ($data.StartsWith("RUN:")) {
        $scripts = $data.Substring(4).Split("|")
        foreach ($s in $scripts) {
            Write-Host "[EXECUTANDO] $s" -ForegroundColor Cyan
            # Lógica de download e execução aqui
            $url = "$BaseUrl/$($s.Replace(" ", "%20"))"
            $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content
            $tempFile = Join-Path $env:TEMP "lobo_run_$($s.Replace("/", "_"))"
            Set-Content -Path $tempFile -Value $content
            if ($s.EndsWith(".bat")) { Start-Process cmd.exe -ArgumentList "/c `"$tempFile`"" -Wait -WindowStyle Hidden }
            elseif ($s.EndsWith(".reg")) { Start-Process reg.exe -ArgumentList "import `"$tempFile`"" -Wait -WindowStyle Hidden }
            Remove-Item $tempFile -Force
        }
        [System.Windows.Forms.MessageBox]::Show("Otimizações concluídas!", "Lobo Alpha")
    } elseif ($data -eq "RESTORE") {
        Write-Host "[RESTORE] Criando ponto de restauração..." -ForegroundColor Magenta
        $url = "$BaseUrl/01_Preparacao_e_Backup/01_CRIAR_PONTO_RESTAURACAO.bat"
        $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content
        $tempFile = Join-Path $env:TEMP "lobo_restore.bat"
        Set-Content -Path $tempFile -Value $content
        Start-Process cmd.exe -ArgumentList "/c `"$tempFile`"" -Wait -WindowStyle Hidden
        Remove-Item $tempFile -Force
        [System.Windows.Forms.MessageBox]::Show("Ponto de restauração criado!", "Lobo Alpha")
    }
}

$browser.ObjectForScripting = $scriptObject
$form.Controls.Add($browser)

# Limpeza ao fechar
$form.Add_FormClosing({
    Remove-Item $tempHtml -Force -ErrorAction SilentlyContinue
})

$form.ShowDialog()
