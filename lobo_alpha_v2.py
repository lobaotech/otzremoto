#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
================================================================
  LOBO ALPHA V2.0 - PREMIUM EDITION
  Toolkit de Otimizacao Windows
  (c) 2026 Lobo Tech - Todos os direitos reservados
================================================================

Interface grafica moderna em Python (CustomTkinter).
Executa scripts de otimizacao remotamente do GitHub.
"""

import customtkinter as ctk
import threading
import subprocess
import tempfile
import os
import sys
import urllib.request
import ssl
import ctypes
import datetime

# ================================================================
# CONFIGURACOES
# ================================================================

REPO_BASE = "https://raw.githubusercontent.com/lobaotech/otzremoto/main"
APP_VERSION = "2.0.0"

# Cores do tema Cyberpunk
COLORS = {
    "bg_dark": "#0a0a0f",
    "bg_panel": "#111118",
    "bg_input": "#16161f",
    "purple": "#9933ff",
    "magenta": "#ff00ff",
    "cyan": "#00ffcc",
    "text": "#e0e0e0",
    "text_dim": "#666680",
    "text_muted": "#444455",
    "border": "#2a2a3a",
    "success": "#00ff88",
    "warning": "#ffaa00",
    "error": "#ff4444",
}

# ================================================================
# DEFINICAO DOS MODULOS DE OTIMIZACAO
# ================================================================

MODULES = {
    "⚡ CPU & Energia": {
        "path": "02_Otimizacao_CPU_e_Energia",
        "scripts": [
            ("Plano de Desempenho Máximo", "01_plano_desempenho_maximo.bat"),
            ("Desbloquear Atributos de Energia", "02_desbloquear_atributos_energia.bat"),
            ("Desativar Core Parking", "06_desativar_core_parking.bat"),
            ("Win32 Priority Separation", "07_win32_priority_separation.bat"),
            ("Desativar Estrangulamento de Energia", "08_desativar_estrangulamento_energia.bat"),
            ("Limpar Planos de Energia", "09_limpar_planos_energia.bat"),
            ("Otimizações de Energia (Registro)", "otimizacoes_energia.reg"),
        ],
    },
    "🎮 GPU & Vídeo": {
        "path": "03_Otimizacao_GPU_e_Video",
        "scripts": [
            ("Agendador Multimídia para Jogos", "03_agendador_multimidia_jogos.bat"),
            ("Agendamento GPU por Hardware", "05_agendamento_gpu_hardware.bat"),
            ("Escala GPU", "06_escala_gpu.bat"),
            ("Game DVR e Tela Cheia", "09_gamedvr_tela_cheia.bat"),
            ("Resetar Cache de Shader", "12_resetar_cache_shader.bat"),
            ("Bloquear Updates de Driver", "15_bloquear_updates_driver.bat"),
        ],
    },
    "🌐 Rede & DNS": {
        "path": "04_Rede_e_DNS",
        "scripts": [
            ("Reset Completo de Rede", "01_reset_rede.bat"),
            ("Receive Side Scaling", "02_receive_side_scaling.bat"),
            ("TCP Auto-Tuning", "03_tcp_autotuning.bat"),
            ("MTU 1400", "04_mtu_1400.bat"),
            ("Desativar IPv6", "05_desativar_ipv6.bat"),
            ("TCP No Delay", "06_tcp_nodelay.bat"),
            ("Índice de Estrangulamento", "07_indice_estrangulamento.bat"),
            ("Limpar Cache DNS", "10_limpar_dns.bat"),
            ("DNS Cloudflare (1.1.1.1)", "11_dns_cloudflare.bat"),
            ("DNS Google (8.8.8.8)", "12_dns_google.bat"),
            ("Otimizador de Rede Completo", "otimizador_rede.bat"),
            ("Otimizações de Rede (Registro)", "otimizacoes_rede.reg"),
        ],
    },
    "🖱️ Input Lag": {
        "path": "05_Input_Lag_e_Perifericos",
        "scripts": [
            ("Buffers de Entrada", "01_buffers_entrada.bat"),
            ("Resposta do Teclado", "02_resposta_teclado.bat"),
            ("Desativar HPET", "03_desativar_hpet.bat"),
            ("Economia USB", "04_economia_usb.bat"),
            ("Modo MSI", "05_modo_msi.bat"),
            ("Timer Resolution", "07_timer_resolution.bat"),
            ("Aceleração do Mouse", "08_aceleracao_mouse.bat"),
            ("Teclas de Aderência", "09_teclas_aderencia.bat"),
            ("Otimizador Input Lag Completo", "otimizador_input_lag.bat"),
            ("Otimizações Input Lag (Registro)", "otimizacoes_input_lag.reg"),
        ],
    },
    "🎯 Gaming": {
        "path": "10_Otimizacoes_por_Jogo",
        "scripts": [
            ("Otimizar Jogo Genérico", "01_otimizar_jogo_generico.bat"),
            ("Otimizar CS2", "02_otimizar_cs2.bat"),
            ("Otimizar Fortnite", "03_otimizar_fortnite.bat"),
            ("Otimizar Valorant", "04_otimizar_valorant.bat"),
            ("Otimizar GTA V", "05_otimizar_gta_v.bat"),
            ("Otimizar FiveM", "06_otimizar_fivem.bat"),
            ("Otimizar Roblox", "07_otimizar_roblox.bat"),
            ("Otimizar Minecraft", "08_otimizar_minecraft.bat"),
            ("Otimizar Battlefield", "09_otimizar_battlefield.bat"),
            ("Otimizar RDR2", "10_otimizar_rdr2.bat"),
        ],
    },
    "🛡️ Debloater & Privacidade": {
        "path": "07_Debloater_e_Privacidade",
        "scripts": [
            ("Remover Xbox Apps", "01_remover_xbox_apps.bat"),
            ("Remover Cortana", "02_remover_cortana.bat"),
            ("Remover Teams", "03_remover_teams.bat"),
            ("Remover OneDrive", "04_remover_onedrive.bat"),
        ],
    },
    "🧹 Limpeza": {
        "path": "08_Limpeza_e_Manutencao",
        "scripts": [
            ("Limpeza Profunda", "08_limpeza_profunda.bat"),
            ("Limpar Logs de Eventos", "11_limpar_logs_eventos.bat"),
            ("Remover Bloatware", "13_remover_bloatware.bat"),
        ],
    },
    "🚀 Boot & Serviços": {
        "path": "09_Inicializacao_e_Servicos",
        "scripts": [
            ("Desativar Superfetch", "01_desativar_superfetch.bat"),
            ("Otimizar Serviços para Jogos", "02_otimizar_servicos_jogos.bat"),
            ("Otimizar Boot", "03_otimizar_boot.bat"),
            ("Desativar Apps de Inicialização", "04_desativar_apps_inicializacao.bat"),
            ("Desativar Indexação", "05_desativar_indexacao.bat"),
            ("Desativar Spooler", "06_desativar_spooler.bat"),
            ("Desativar Windows Update", "07_desativar_windows_update.bat"),
            ("Resetar Cache de Update", "10_resetar_cache_update.bat"),
            ("Desativar Apps em Segundo Plano", "14_desativar_apps_segundo_plano.bat"),
        ],
    },
    "💾 Memória RAM": {
        "path": "06_Memoria_RAM",
        "scripts": [
            ("Ajustes de Memória RAM", "01_ajustes_memoria_ram.bat"),
        ],
    },
    "🔧 Reparo & Diagnóstico": {
        "path": "12_Reparo_e_Diagnostico",
        "scripts": [
            ("DISM - Restaurar Saúde", "16_dism_restaurar_saude.bat"),
            ("SFC Scannow", "17_sfc_scannow.bat"),
            ("Agendar CHKDSK", "18_agendar_chkdsk.bat"),
            ("Atualizar Drivers do SO", "19_atualizar_drivers_so.bat"),
        ],
    },
}

# ================================================================
# VERIFICACAO DE ADMINISTRADOR
# ================================================================

def is_admin():
    """Verifica se o programa está a correr como administrador."""
    try:
        return ctypes.windll.shell32.IsUserAnAdmin() != 0
    except Exception:
        return False


def run_as_admin():
    """Reinicia o programa como administrador."""
    try:
        ctypes.windll.shell32.ShellExecuteW(
            None, "runas", sys.executable, " ".join(sys.argv), None, 1
        )
        sys.exit(0)
    except Exception:
        pass


# ================================================================
# CLASSE PRINCIPAL DA APLICACAO
# ================================================================

class LoboAlphaApp(ctk.CTk):
    def __init__(self):
        super().__init__()

        # Configuração da janela
        self.title(f"LOBO ALPHA V{APP_VERSION} // PREMIUM")
        self.geometry("1000x700")
        self.minsize(900, 600)
        self.configure(fg_color=COLORS["bg_dark"])

        # Variáveis de estado
        self.checkboxes = {}  # {module_name: {script_name: (var, checkbox_widget)}}
        self.is_running = False

        # Construir interface
        self._build_header()
        self._build_main()
        self._build_footer()

        # Log inicial
        self.log("Sistema inicializado com sucesso.", "success")
        self.log(f"Lobo Alpha V{APP_VERSION} Premium — Pronto para otimizar.", "info")
        self.log(f"Repositório: {REPO_BASE}", "info")

    # ──────────────────────────────────────────────────────────
    # HEADER
    # ──────────────────────────────────────────────────────────

    def _build_header(self):
        header = ctk.CTkFrame(self, fg_color=COLORS["bg_panel"], height=70, corner_radius=0)
        header.pack(fill="x", padx=0, pady=0)
        header.pack_propagate(False)

        # Logo e título
        title_frame = ctk.CTkFrame(header, fg_color="transparent")
        title_frame.pack(side="left", padx=20, pady=10)

        ctk.CTkLabel(
            title_frame,
            text="🐺 LOBO ALPHA V2.0",
            font=ctk.CTkFont(family="Segoe UI", size=20, weight="bold"),
            text_color=COLORS["purple"],
        ).pack(anchor="w")

        ctk.CTkLabel(
            title_frame,
            text="PREMIUM EDITION  //  LOBO TECH",
            font=ctk.CTkFont(family="Consolas", size=10),
            text_color=COLORS["text_dim"],
        ).pack(anchor="w")

        # Status
        status_frame = ctk.CTkFrame(header, fg_color="transparent")
        status_frame.pack(side="right", padx=20, pady=10)

        admin_text = "✅ ADMIN" if is_admin() else "⚠️ SEM ADMIN"
        admin_color = COLORS["success"] if is_admin() else COLORS["warning"]

        ctk.CTkLabel(
            status_frame,
            text=admin_text,
            font=ctk.CTkFont(family="Consolas", size=11),
            text_color=admin_color,
        ).pack(anchor="e")

        ctk.CTkLabel(
            status_frame,
            text=datetime.datetime.now().strftime("%d/%m/%Y  %H:%M"),
            font=ctk.CTkFont(family="Consolas", size=10),
            text_color=COLORS["text_muted"],
        ).pack(anchor="e")

    # ──────────────────────────────────────────────────────────
    # MAIN AREA
    # ──────────────────────────────────────────────────────────

    def _build_main(self):
        main_frame = ctk.CTkFrame(self, fg_color="transparent")
        main_frame.pack(fill="both", expand=True, padx=10, pady=(5, 0))

        # Painel esquerdo: Abas com scripts
        left_panel = ctk.CTkFrame(main_frame, fg_color="transparent")
        left_panel.pack(side="left", fill="both", expand=True, padx=(0, 5))

        self.tabview = ctk.CTkTabview(
            left_panel,
            fg_color=COLORS["bg_panel"],
            segmented_button_fg_color=COLORS["bg_input"],
            segmented_button_selected_color=COLORS["purple"],
            segmented_button_selected_hover_color="#7722cc",
            segmented_button_unselected_color=COLORS["bg_input"],
            segmented_button_unselected_hover_color="#1e1e2e",
            border_color=COLORS["border"],
            border_width=1,
            corner_radius=8,
        )
        self.tabview.pack(fill="both", expand=True)

        # Criar abas
        for module_name, module_data in MODULES.items():
            tab = self.tabview.add(module_name)
            self._build_module_tab(tab, module_name, module_data)

        # Painel direito: Ações + Console
        right_panel = ctk.CTkFrame(main_frame, fg_color="transparent", width=280)
        right_panel.pack(side="right", fill="y", padx=(5, 0))
        right_panel.pack_propagate(False)

        self._build_actions_panel(right_panel)
        self._build_console(right_panel)

    def _build_module_tab(self, parent, module_name, module_data):
        """Constrói o conteúdo de uma aba de módulo."""
        self.checkboxes[module_name] = {}

        # Frame com scroll
        scroll_frame = ctk.CTkScrollableFrame(
            parent,
            fg_color="transparent",
            scrollbar_button_color=COLORS["purple"],
            scrollbar_button_hover_color=COLORS["magenta"],
        )
        scroll_frame.pack(fill="both", expand=True, padx=5, pady=5)

        # Header da aba
        header_frame = ctk.CTkFrame(scroll_frame, fg_color=COLORS["bg_input"], corner_radius=6)
        header_frame.pack(fill="x", pady=(0, 8))

        ctk.CTkLabel(
            header_frame,
            text=f"  {module_name}  —  {len(module_data['scripts'])} scripts disponíveis",
            font=ctk.CTkFont(family="Segoe UI", size=12, weight="bold"),
            text_color=COLORS["cyan"],
            anchor="w",
        ).pack(fill="x", padx=10, pady=8)

        # Botões selecionar/desselecionar tudo
        btn_frame = ctk.CTkFrame(scroll_frame, fg_color="transparent")
        btn_frame.pack(fill="x", pady=(0, 8))

        ctk.CTkButton(
            btn_frame,
            text="✅ Selecionar Tudo",
            font=ctk.CTkFont(size=11),
            fg_color=COLORS["bg_input"],
            hover_color="#1e1e2e",
            border_color=COLORS["border"],
            border_width=1,
            height=28,
            corner_radius=4,
            command=lambda mn=module_name: self._select_all(mn, True),
        ).pack(side="left", padx=(0, 5))

        ctk.CTkButton(
            btn_frame,
            text="❌ Desselecionar Tudo",
            font=ctk.CTkFont(size=11),
            fg_color=COLORS["bg_input"],
            hover_color="#1e1e2e",
            border_color=COLORS["border"],
            border_width=1,
            height=28,
            corner_radius=4,
            command=lambda mn=module_name: self._select_all(mn, False),
        ).pack(side="left")

        # Checkboxes dos scripts
        for display_name, script_file in module_data["scripts"]:
            var = ctk.BooleanVar(value=False)

            cb_frame = ctk.CTkFrame(scroll_frame, fg_color="transparent")
            cb_frame.pack(fill="x", pady=1)

            cb = ctk.CTkCheckBox(
                cb_frame,
                text="",
                variable=var,
                width=24,
                height=24,
                fg_color=COLORS["purple"],
                hover_color=COLORS["magenta"],
                border_color=COLORS["border"],
                checkmark_color="white",
                corner_radius=4,
            )
            cb.pack(side="left", padx=(5, 8))

            # Nome legível
            ctk.CTkLabel(
                cb_frame,
                text=display_name,
                font=ctk.CTkFont(family="Segoe UI", size=13),
                text_color=COLORS["text"],
                anchor="w",
            ).pack(side="left", fill="x", expand=True)

            # Nome do ficheiro
            ctk.CTkLabel(
                cb_frame,
                text=script_file,
                font=ctk.CTkFont(family="Consolas", size=10),
                text_color=COLORS["text_muted"],
                anchor="e",
            ).pack(side="right", padx=5)

            self.checkboxes[module_name][script_file] = (var, cb)

    def _build_actions_panel(self, parent):
        """Constrói o painel de ações à direita."""
        actions_frame = ctk.CTkFrame(parent, fg_color=COLORS["bg_panel"], corner_radius=8, border_color=COLORS["border"], border_width=1)
        actions_frame.pack(fill="x", pady=(0, 5))

        ctk.CTkLabel(
            actions_frame,
            text="AÇÕES",
            font=ctk.CTkFont(family="Segoe UI", size=13, weight="bold"),
            text_color=COLORS["purple"],
        ).pack(pady=(12, 8))

        # Botão: Criar Ponto de Restauração
        ctk.CTkButton(
            actions_frame,
            text="🛡️  Ponto de Restauração",
            font=ctk.CTkFont(family="Segoe UI", size=13, weight="bold"),
            fg_color="#1a1a2e",
            hover_color="#2a1a3e",
            border_color=COLORS["magenta"],
            border_width=1,
            height=42,
            corner_radius=6,
            command=self._create_restore_point,
        ).pack(fill="x", padx=12, pady=4)

        # Botão: Aplicar Selecionados
        self.apply_btn = ctk.CTkButton(
            actions_frame,
            text="⚡  APLICAR TWEAKS",
            font=ctk.CTkFont(family="Segoe UI", size=14, weight="bold"),
            fg_color=COLORS["purple"],
            hover_color="#7722cc",
            height=48,
            corner_radius=6,
            command=self._apply_tweaks,
        )
        self.apply_btn.pack(fill="x", padx=12, pady=4)

        # Botão: Aplicar TUDO
        ctk.CTkButton(
            actions_frame,
            text="🔥  APLICAR TUDO",
            font=ctk.CTkFont(family="Segoe UI", size=13, weight="bold"),
            fg_color="#331155",
            hover_color="#441166",
            border_color=COLORS["purple"],
            border_width=1,
            height=42,
            corner_radius=6,
            command=self._apply_all,
        ).pack(fill="x", padx=12, pady=(4, 12))

        # Info box
        info_frame = ctk.CTkFrame(parent, fg_color=COLORS["bg_panel"], corner_radius=8, border_color=COLORS["border"], border_width=1)
        info_frame.pack(fill="x", pady=5)

        ctk.CTkLabel(
            info_frame,
            text="ℹ️  INFORMAÇÃO",
            font=ctk.CTkFont(family="Segoe UI", size=11, weight="bold"),
            text_color=COLORS["text_dim"],
        ).pack(pady=(10, 4))

        ctk.CTkLabel(
            info_frame,
            text="Os scripts são descarregados\ndo GitHub e executados\nlocalmente. Nenhum ficheiro\npermanece no sistema.",
            font=ctk.CTkFont(family="Segoe UI", size=11),
            text_color=COLORS["text_muted"],
            justify="center",
        ).pack(padx=10, pady=(0, 10))

    def _build_console(self, parent):
        """Constrói o console de log."""
        console_frame = ctk.CTkFrame(parent, fg_color=COLORS["bg_panel"], corner_radius=8, border_color=COLORS["border"], border_width=1)
        console_frame.pack(fill="both", expand=True, pady=(5, 0))

        ctk.CTkLabel(
            console_frame,
            text="📋  LOG DE EXECUÇÃO",
            font=ctk.CTkFont(family="Segoe UI", size=11, weight="bold"),
            text_color=COLORS["text_dim"],
        ).pack(pady=(8, 4))

        self.console = ctk.CTkTextbox(
            console_frame,
            font=ctk.CTkFont(family="Consolas", size=11),
            fg_color="#08080e",
            text_color=COLORS["cyan"],
            border_color=COLORS["border"],
            border_width=1,
            corner_radius=4,
            wrap="word",
            state="disabled",
        )
        self.console.pack(fill="both", expand=True, padx=8, pady=(0, 8))

    # ──────────────────────────────────────────────────────────
    # FOOTER
    # ──────────────────────────────────────────────────────────

    def _build_footer(self):
        footer = ctk.CTkFrame(self, fg_color=COLORS["bg_panel"], height=35, corner_radius=0)
        footer.pack(fill="x", padx=0, pady=0)
        footer.pack_propagate(False)

        ctk.CTkLabel(
            footer,
            text=f"© 2026 Lobo Tech  |  Lobo Alpha V{APP_VERSION} Premium  |  github.com/lobaotech",
            font=ctk.CTkFont(family="Consolas", size=10),
            text_color=COLORS["text_muted"],
        ).pack(expand=True)

    # ──────────────────────────────────────────────────────────
    # LÓGICA DE EXECUÇÃO
    # ──────────────────────────────────────────────────────────

    def log(self, message, level="info"):
        """Adiciona mensagem ao console de log."""
        timestamp = datetime.datetime.now().strftime("%H:%M:%S")
        prefix_map = {
            "info": "[INFO]",
            "success": "[ OK ]",
            "warning": "[WARN]",
            "error": "[ERRO]",
            "running": "[ >> ]",
        }
        prefix = prefix_map.get(level, "[LOG]")
        full_msg = f"[{timestamp}] {prefix} {message}\n"

        self.console.configure(state="normal")
        self.console.insert("end", full_msg)
        self.console.see("end")
        self.console.configure(state="disabled")

    def _select_all(self, module_name, state):
        """Seleciona ou desseleciona todos os scripts de um módulo."""
        for script_file, (var, cb) in self.checkboxes[module_name].items():
            var.set(state)

    def _get_selected_scripts(self):
        """Retorna lista de (module_path, script_file) selecionados."""
        selected = []
        for module_name, scripts in self.checkboxes.items():
            module_path = MODULES[module_name]["path"]
            for script_file, (var, cb) in scripts.items():
                if var.get():
                    selected.append((module_path, script_file))
        return selected

    def _download_and_run(self, module_path, script_file):
        """Descarrega um script do GitHub e executa-o."""
        url = f"{REPO_BASE}/{module_path}/{script_file}"
        self.log(f"A descarregar: {script_file}", "running")

        try:
            # Criar contexto SSL que aceita certificados
            ctx = ssl.create_default_context()
            ctx.check_hostname = False
            ctx.verify_mode = ssl.CERT_NONE

            req = urllib.request.Request(url, headers={"User-Agent": "LoboAlpha/2.0"})
            with urllib.request.urlopen(req, context=ctx) as response:
                content = response.read()

            # Guardar em ficheiro temporário
            suffix = os.path.splitext(script_file)[1]
            temp_file = os.path.join(tempfile.gettempdir(), f"lobo_{script_file}")

            with open(temp_file, "wb") as f:
                f.write(content)

            self.log(f"A executar: {script_file}", "running")

            # Executar conforme o tipo
            if suffix.lower() == ".bat":
                result = subprocess.run(
                    ["cmd.exe", "/c", temp_file],
                    capture_output=True,
                    text=True,
                    timeout=120,
                    creationflags=subprocess.CREATE_NO_WINDOW if sys.platform == "win32" else 0,
                )
            elif suffix.lower() == ".reg":
                result = subprocess.run(
                    ["reg.exe", "import", temp_file],
                    capture_output=True,
                    text=True,
                    timeout=30,
                    creationflags=subprocess.CREATE_NO_WINDOW if sys.platform == "win32" else 0,
                )
            elif suffix.lower() == ".ps1":
                result = subprocess.run(
                    ["powershell.exe", "-ExecutionPolicy", "Bypass", "-File", temp_file],
                    capture_output=True,
                    text=True,
                    timeout=120,
                    creationflags=subprocess.CREATE_NO_WINDOW if sys.platform == "win32" else 0,
                )
            else:
                self.log(f"Tipo de ficheiro não suportado: {suffix}", "warning")
                return False

            # Limpar ficheiro temporário
            try:
                os.remove(temp_file)
            except Exception:
                pass

            if result.returncode == 0:
                self.log(f"Concluído: {script_file}", "success")
                return True
            else:
                error_msg = result.stderr.strip() if result.stderr else "Código de saída não-zero"
                self.log(f"Aviso em {script_file}: {error_msg[:100]}", "warning")
                return True  # Alguns scripts retornam código != 0 mas funcionam

        except urllib.error.URLError as e:
            self.log(f"Erro de rede ao descarregar {script_file}: {str(e)[:80]}", "error")
            return False
        except subprocess.TimeoutExpired:
            self.log(f"Timeout ao executar {script_file}", "error")
            return False
        except Exception as e:
            self.log(f"Erro em {script_file}: {str(e)[:80]}", "error")
            return False

    def _apply_tweaks(self):
        """Aplica os tweaks selecionados."""
        if self.is_running:
            self.log("Já existe uma execução em andamento!", "warning")
            return

        selected = self._get_selected_scripts()
        if not selected:
            self.log("Nenhum script selecionado! Selecione ao menos um.", "warning")
            return

        self.log(f"Iniciando execução de {len(selected)} script(s)...", "info")
        self.is_running = True
        self.apply_btn.configure(state="disabled", text="⏳  EXECUTANDO...")

        def run_thread():
            success_count = 0
            fail_count = 0

            for module_path, script_file in selected:
                result = self._download_and_run(module_path, script_file)
                if result:
                    success_count += 1
                else:
                    fail_count += 1

            self.log("", "info")
            self.log(f"═══ RESULTADO FINAL ═══", "info")
            self.log(f"Sucesso: {success_count}  |  Falhas: {fail_count}  |  Total: {len(selected)}", "success" if fail_count == 0 else "warning")
            self.log(f"Otimização concluída!", "success")

            self.is_running = False
            self.apply_btn.configure(state="normal", text="⚡  APLICAR TWEAKS")

        thread = threading.Thread(target=run_thread, daemon=True)
        thread.start()

    def _apply_all(self):
        """Seleciona tudo e aplica."""
        for module_name in self.checkboxes:
            self._select_all(module_name, True)
        self._apply_tweaks()

    def _create_restore_point(self):
        """Cria um ponto de restauração do sistema."""
        if self.is_running:
            self.log("Aguarde a execução atual terminar.", "warning")
            return

        self.log("Criando ponto de restauração do sistema...", "running")
        self.is_running = True

        def run_thread():
            result = self._download_and_run("01_Preparacao_e_Backup", "01_CRIAR_PONTO_RESTAURACAO.bat")
            if result:
                self.log("Ponto de restauração criado com sucesso!", "success")
            else:
                self.log("Falha ao criar ponto de restauração.", "error")
            self.is_running = False

        thread = threading.Thread(target=run_thread, daemon=True)
        thread.start()


# ================================================================
# PONTO DE ENTRADA
# ================================================================

def main():
    # Verificar administrador (apenas no Windows)
    if sys.platform == "win32" and not is_admin():
        run_as_admin()
        return

    # Configurar tema
    ctk.set_appearance_mode("dark")
    ctk.set_default_color_theme("blue")

    # Iniciar aplicação
    app = LoboAlphaApp()
    app.mainloop()


if __name__ == "__main__":
    main()
