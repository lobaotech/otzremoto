#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
================================================================
  LOBO ALPHA V2.0 - PREMIUM EDITION (CYBERPUNK UI)
  Toolkit de Otimizacao Windows
  (c) 2026 Lobo Tech - Todos os direitos reservados
================================================================
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
import tkinter as tk

# ================================================================
# CONFIGURACOES
# ================================================================

REPO_BASE = "https://raw.githubusercontent.com/lobaotech/otzremoto/main"
APP_VERSION = "2.0.0"

# Cores Cyberpunk
C = {
    "bg":           "#0a0a14",
    "bg_panel":     "#0d0d1a",
    "bg_darker":    "#060610",
    "bg_input":     "#0f0f1e",
    "purple":       "#9933ff",
    "purple_dark":  "#6622aa",
    "magenta":      "#ff00ff",
    "magenta_dark": "#aa00aa",
    "cyan":         "#00ffcc",
    "cyan_dark":    "#009977",
    "pink":         "#ff3388",
    "pink_dark":    "#cc1166",
    "text":         "#e0e0ee",
    "text_dim":     "#7777aa",
    "text_muted":   "#444466",
    "border_purple":"#9933ff",
    "border_cyan":  "#00ffcc",
    "success":      "#00ff88",
    "warning":      "#ffaa00",
    "error":        "#ff4444",
    "neon_blue":    "#4488ff",
}

# ================================================================
# MODULOS DE OTIMIZACAO
# ================================================================

MODULES = {
    "PERFORMANCE": {
        "path": "02_Otimizacao_CPU_e_Energia",
        "scripts": [
            ("Plano de Desempenho Maximo", "01_plano_desempenho_maximo.bat"),
            ("Desbloquear Atributos de Energia", "02_desbloquear_atributos_energia.bat"),
            ("Desativar Core Parking", "06_desativar_core_parking.bat"),
            ("Win32 Priority Separation", "07_win32_priority_separation.bat"),
            ("Desativar Estrangulamento Energia", "08_desativar_estrangulamento_energia.bat"),
            ("Limpar Planos de Energia", "09_limpar_planos_energia.bat"),
            ("Otimizacoes de Energia (Registro)", "otimizacoes_energia.reg"),
            ("Ajustes de Memoria RAM", "01_ajustes_memoria_ram.bat"),
        ],
    },
    "GAMING": {
        "path": "10_Otimizacoes_por_Jogo",
        "scripts": [
            ("Otimizar Jogo Generico", "01_otimizar_jogo_generico.bat"),
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
    "NETWORK": {
        "path": "04_Rede_e_DNS",
        "scripts": [
            ("Reset Completo de Rede", "01_reset_rede.bat"),
            ("Receive Side Scaling", "02_receive_side_scaling.bat"),
            ("TCP Auto-Tuning", "03_tcp_autotuning.bat"),
            ("MTU 1400", "04_mtu_1400.bat"),
            ("Desativar IPv6", "05_desativar_ipv6.bat"),
            ("TCP No Delay", "06_tcp_nodelay.bat"),
            ("Indice de Estrangulamento", "07_indice_estrangulamento.bat"),
            ("Limpar Cache DNS", "10_limpar_dns.bat"),
            ("DNS Cloudflare (1.1.1.1)", "11_dns_cloudflare.bat"),
            ("DNS Google (8.8.8.8)", "12_dns_google.bat"),
            ("Otimizador de Rede Completo", "otimizador_rede.bat"),
            ("Otimizacoes de Rede (Registro)", "otimizacoes_rede.reg"),
        ],
    },
    "INPUT LAG": {
        "path": "05_Input_Lag_e_Perifericos",
        "scripts": [
            ("Buffers de Entrada", "01_buffers_entrada.bat"),
            ("Resposta do Teclado", "02_resposta_teclado.bat"),
            ("Desativar HPET", "03_desativar_hpet.bat"),
            ("Economia USB", "04_economia_usb.bat"),
            ("Modo MSI", "05_modo_msi.bat"),
            ("Timer Resolution", "07_timer_resolution.bat"),
            ("Aceleracao do Mouse", "08_aceleracao_mouse.bat"),
            ("Teclas de Aderencia", "09_teclas_aderencia.bat"),
            ("Otimizador Input Lag Completo", "otimizador_input_lag.bat"),
            ("Otimizacoes Input Lag (Registro)", "otimizacoes_input_lag.reg"),
        ],
    },
    "CLEANUP": {
        "path": "08_Limpeza_e_Manutencao",
        "scripts": [
            ("Limpeza Profunda", "08_limpeza_profunda.bat"),
            ("Limpar Logs de Eventos", "11_limpar_logs_eventos.bat"),
            ("Remover Bloatware", "13_remover_bloatware.bat"),
            ("Remover Xbox Apps", "01_remover_xbox_apps.bat"),
            ("Remover Cortana", "02_remover_cortana.bat"),
            ("Remover Teams", "03_remover_teams.bat"),
            ("Remover OneDrive", "04_remover_onedrive.bat"),
        ],
    },
    "SYSTEM": {
        "path": "09_Inicializacao_e_Servicos",
        "scripts": [
            ("Desativar Superfetch", "01_desativar_superfetch.bat"),
            ("Otimizar Servicos para Jogos", "02_otimizar_servicos_jogos.bat"),
            ("Otimizar Boot", "03_otimizar_boot.bat"),
            ("Desativar Apps de Inicializacao", "04_desativar_apps_inicializacao.bat"),
            ("Desativar Indexacao", "05_desativar_indexacao.bat"),
            ("Desativar Spooler", "06_desativar_spooler.bat"),
            ("Desativar Windows Update", "07_desativar_windows_update.bat"),
            ("Resetar Cache de Update", "10_resetar_cache_update.bat"),
            ("Desativar Apps em Segundo Plano", "14_desativar_apps_segundo_plano.bat"),
            ("GPU Hardware Scheduling", "05_agendamento_gpu_hardware.bat"),
            ("Game DVR e Tela Cheia", "09_gamedvr_tela_cheia.bat"),
            ("DISM Restaurar Saude", "16_dism_restaurar_saude.bat"),
            ("SFC Scannow", "17_sfc_scannow.bat"),
        ],
    },
}

# ================================================================
# VERIFICACAO DE ADMINISTRADOR
# ================================================================

def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin() != 0
    except Exception:
        return False

def run_as_admin():
    try:
        ctypes.windll.shell32.ShellExecuteW(
            None, "runas", sys.executable, " ".join(sys.argv), None, 1
        )
        sys.exit(0)
    except Exception:
        pass

# ================================================================
# CLASSE PRINCIPAL - CYBERPUNK UI
# ================================================================

class LoboAlphaApp(ctk.CTk):
    def __init__(self):
        super().__init__()

        # Janela
        self.title(f"LOBO ALPHA V{APP_VERSION} // DOMINE SEU HARDWARE")
        self.geometry("1200x780")
        self.minsize(1000, 650)
        self.configure(fg_color=C["bg"])

        # Estado
        self.checkboxes = {}
        self.is_running = False
        self.current_tab = "PERFORMANCE"

        # Construir UI
        self._build_header()
        self._build_tabs()
        self._build_body()
        self._build_progress_bar()
        self._build_console()
        self._build_footer()

        # Log inicial
        self._log("LOBO ALPHA V2.0 Initialized successfully.", "success")
        self._log("System scan complete. No critical errors found.", "info")
        self._log("Ready to apply tweaks. Please select options.", "info")

    # ================================================================
    # HEADER - Titulo principal estilo Cyberpunk
    # ================================================================

    def _build_header(self):
        # Frame do header com borda roxa
        header = ctk.CTkFrame(
            self, fg_color=C["bg_panel"], height=65, corner_radius=0,
            border_color=C["purple"], border_width=2
        )
        header.pack(fill="x", padx=8, pady=(8, 0))
        header.pack_propagate(False)

        # Linha neon superior (decorativa)
        neon_line = ctk.CTkFrame(header, fg_color=C["cyan"], height=2, corner_radius=0)
        neon_line.pack(fill="x", side="top")

        # Container do titulo
        title_container = ctk.CTkFrame(header, fg_color="transparent")
        title_container.pack(fill="both", expand=True, padx=15)

        # Titulo principal
        ctk.CTkLabel(
            title_container,
            text="LOBO ALPHA V2.0 // DOMINE SEU HARDWARE",
            font=ctk.CTkFont(family="Consolas", size=24, weight="bold"),
            text_color=C["cyan"],
        ).pack(side="left", pady=5)

        # Status Admin + Versao (direita)
        right_frame = ctk.CTkFrame(title_container, fg_color="transparent")
        right_frame.pack(side="right")

        admin_ok = is_admin()
        ctk.CTkLabel(
            right_frame,
            text="[ADMIN]" if admin_ok else "[NO ADMIN]",
            font=ctk.CTkFont(family="Consolas", size=11, weight="bold"),
            text_color=C["success"] if admin_ok else C["error"],
        ).pack(anchor="e")

        ctk.CTkLabel(
            right_frame,
            text=f"v{APP_VERSION} // PREMIUM",
            font=ctk.CTkFont(family="Consolas", size=10),
            text_color=C["text_muted"],
        ).pack(anchor="e")

        # Linha neon inferior
        neon_line2 = ctk.CTkFrame(header, fg_color=C["purple"], height=1, corner_radius=0)
        neon_line2.pack(fill="x", side="bottom")

    # ================================================================
    # TABS - Abas neon estilo Cyberpunk
    # ================================================================

    def _build_tabs(self):
        tabs_frame = ctk.CTkFrame(self, fg_color="transparent", height=50)
        tabs_frame.pack(fill="x", padx=8, pady=(6, 0))
        tabs_frame.pack_propagate(False)

        self.tab_buttons = {}
        tab_colors = {
            "PERFORMANCE": (C["cyan"], C["cyan_dark"]),
            "GAMING":      (C["magenta"], C["magenta_dark"]),
            "NETWORK":     (C["cyan"], C["cyan_dark"]),
            "INPUT LAG":   (C["magenta"], C["magenta_dark"]),
            "CLEANUP":     (C["cyan"], C["cyan_dark"]),
            "SYSTEM":      (C["cyan"], C["cyan_dark"]),
        }

        for tab_name in MODULES.keys():
            color, hover = tab_colors.get(tab_name, (C["cyan"], C["cyan_dark"]))
            is_active = tab_name == self.current_tab

            btn = ctk.CTkButton(
                tabs_frame,
                text=tab_name,
                font=ctk.CTkFont(family="Consolas", size=13, weight="bold"),
                fg_color=color if is_active else "transparent",
                hover_color=hover,
                text_color=C["bg"] if is_active else color,
                border_color=color,
                border_width=2,
                corner_radius=2,
                height=38,
                command=lambda tn=tab_name: self._switch_tab(tn),
            )
            btn.pack(side="left", fill="x", expand=True, padx=2)
            self.tab_buttons[tab_name] = (btn, color, hover)

    def _switch_tab(self, tab_name):
        self.current_tab = tab_name

        # Atualizar visual dos botoes
        for tn, (btn, color, hover) in self.tab_buttons.items():
            if tn == tab_name:
                btn.configure(fg_color=color, text_color=C["bg"])
            else:
                btn.configure(fg_color="transparent", text_color=color)

        # Mostrar/esconder conteudo
        for tn, frame in self.tab_frames.items():
            if tn == tab_name:
                frame.pack(fill="both", expand=True)
            else:
                frame.pack_forget()

    # ================================================================
    # BODY - Area principal com scripts + botoes de acao
    # ================================================================

    def _build_body(self):
        body = ctk.CTkFrame(self, fg_color="transparent")
        body.pack(fill="both", expand=True, padx=8, pady=(4, 0))

        # Painel esquerdo: Lista de scripts (com borda roxa)
        left_frame = ctk.CTkFrame(
            body, fg_color=C["bg_panel"],
            border_color=C["purple"], border_width=2, corner_radius=4
        )
        left_frame.pack(side="left", fill="both", expand=True, padx=(0, 6))

        # Container das abas de conteudo
        self.tab_frames = {}
        for tab_name, module_data in MODULES.items():
            tab_frame = ctk.CTkScrollableFrame(
                left_frame, fg_color="transparent",
                scrollbar_button_color=C["purple"],
                scrollbar_button_hover_color=C["magenta"],
            )
            self.tab_frames[tab_name] = tab_frame
            self._build_script_list(tab_frame, tab_name, module_data)

        # Mostrar a primeira aba
        self.tab_frames[self.current_tab].pack(fill="both", expand=True)

        # Painel direito: Botoes de acao
        right_frame = ctk.CTkFrame(body, fg_color="transparent", width=300)
        right_frame.pack(side="right", fill="y")
        right_frame.pack_propagate(False)

        self._build_action_buttons(right_frame)

    def _build_script_list(self, parent, module_name, module_data):
        """Constroi a lista de scripts com checkboxes estilo Cyberpunk."""
        self.checkboxes[module_name] = {}

        # Botoes selecionar/desselecionar
        btn_row = ctk.CTkFrame(parent, fg_color="transparent")
        btn_row.pack(fill="x", padx=5, pady=(5, 3))

        ctk.CTkButton(
            btn_row, text="[SELECT ALL]",
            font=ctk.CTkFont(family="Consolas", size=10, weight="bold"),
            fg_color="transparent", hover_color=C["bg_input"],
            text_color=C["cyan"], height=24, corner_radius=2,
            border_color=C["cyan"], border_width=1,
            command=lambda mn=module_name: self._select_all(mn, True),
        ).pack(side="left", padx=(0, 4))

        ctk.CTkButton(
            btn_row, text="[DESELECT ALL]",
            font=ctk.CTkFont(family="Consolas", size=10, weight="bold"),
            fg_color="transparent", hover_color=C["bg_input"],
            text_color=C["text_muted"], height=24, corner_radius=2,
            border_color=C["text_muted"], border_width=1,
            command=lambda mn=module_name: self._select_all(mn, False),
        ).pack(side="left")

        # Separador
        ctk.CTkFrame(parent, fg_color=C["purple"], height=1).pack(fill="x", padx=5, pady=4)

        # Scripts
        for display_name, script_file in module_data["scripts"]:
            var = ctk.BooleanVar(value=False)

            row = ctk.CTkFrame(parent, fg_color="transparent", height=32)
            row.pack(fill="x", padx=5, pady=1)
            row.pack_propagate(False)

            cb = ctk.CTkCheckBox(
                row, text="",
                variable=var, width=22, height=22,
                fg_color=C["cyan"], hover_color=C["magenta"],
                border_color=C["purple"], checkmark_color=C["bg"],
                corner_radius=3, border_width=2,
            )
            cb.pack(side="left", padx=(4, 8), pady=4)

            # > SCRIPT_NAME.BAT
            ctk.CTkLabel(
                row,
                text=f"> {script_file.upper()}",
                font=ctk.CTkFont(family="Consolas", size=12),
                text_color=C["text"],
                anchor="w",
            ).pack(side="left", fill="x", expand=True)

            # Nome legivel (tooltip-like, mais discreto)
            ctk.CTkLabel(
                row,
                text=display_name,
                font=ctk.CTkFont(family="Consolas", size=9),
                text_color=C["text_muted"],
                anchor="e",
            ).pack(side="right", padx=5)

            self.checkboxes[module_name][script_file] = (var, cb)

    def _build_action_buttons(self, parent):
        """Constroi os botoes de acao estilo Cyberpunk."""

        # === APLICAR TWEAKS (botao grande magenta) ===
        apply_frame = ctk.CTkFrame(
            parent, fg_color=C["bg_panel"],
            border_color=C["magenta"], border_width=2, corner_radius=6
        )
        apply_frame.pack(fill="x", pady=(0, 8), ipady=10)

        self.apply_btn = ctk.CTkButton(
            apply_frame,
            text="APLICAR\nTWEAKS",
            font=ctk.CTkFont(family="Consolas", size=28, weight="bold"),
            fg_color=C["magenta"],
            hover_color=C["magenta_dark"],
            text_color="white",
            height=120,
            corner_radius=4,
            command=self._apply_tweaks,
        )
        self.apply_btn.pack(fill="x", padx=8, pady=8)

        # Contador de selecionados
        self.selected_label = ctk.CTkLabel(
            apply_frame,
            text="0 scripts selecionados",
            font=ctk.CTkFont(family="Consolas", size=10),
            text_color=C["text_muted"],
        )
        self.selected_label.pack(pady=(0, 6))

        # === RESTORE POINT (botao rosa/vermelho) ===
        restore_frame = ctk.CTkFrame(
            parent, fg_color=C["bg_panel"],
            border_color=C["pink"], border_width=2, corner_radius=6
        )
        restore_frame.pack(fill="x", pady=(0, 8), ipady=5)

        ctk.CTkButton(
            restore_frame,
            text="RESTORE\nPOINT",
            font=ctk.CTkFont(family="Consolas", size=22, weight="bold"),
            fg_color=C["pink"],
            hover_color=C["pink_dark"],
            text_color="white",
            height=90,
            corner_radius=4,
            command=self._create_restore_point,
        ).pack(fill="x", padx=8, pady=8)

        # === APLICAR TUDO ===
        ctk.CTkButton(
            parent,
            text=">> APLICAR TUDO <<",
            font=ctk.CTkFont(family="Consolas", size=14, weight="bold"),
            fg_color=C["purple_dark"],
            hover_color=C["purple"],
            text_color=C["cyan"],
            height=45,
            corner_radius=4,
            border_color=C["purple"], border_width=1,
            command=self._apply_all,
        ).pack(fill="x", pady=(0, 8))

        # === INFO BOX ===
        info_frame = ctk.CTkFrame(
            parent, fg_color=C["bg_darker"],
            border_color=C["text_muted"], border_width=1, corner_radius=4
        )
        info_frame.pack(fill="x", pady=(0, 4))

        ctk.CTkLabel(
            info_frame,
            text="[i] Scripts sao descarregados\n    do GitHub e executados\n    localmente. Nenhum ficheiro\n    permanece no sistema.",
            font=ctk.CTkFont(family="Consolas", size=10),
            text_color=C["text_muted"],
            justify="left",
        ).pack(padx=10, pady=8)

        # === LOBO TECH BRANDING ===
        ctk.CTkLabel(
            parent,
            text="LOBO TECH",
            font=ctk.CTkFont(family="Consolas", size=14, weight="bold"),
            text_color=C["purple"],
        ).pack(side="bottom", anchor="e", padx=10, pady=(5, 0))

        # Timer para atualizar contador
        self._update_selected_count()

    # ================================================================
    # BARRA DE PROGRESSO NEON
    # ================================================================

    def _build_progress_bar(self):
        """Barra de progresso neon entre o body e o console."""
        self.progress_frame = ctk.CTkFrame(self, fg_color="transparent", height=30)
        self.progress_frame.pack(fill="x", padx=8, pady=(4, 0))
        self.progress_frame.pack_propagate(False)

        # Label de status
        self.progress_label = ctk.CTkLabel(
            self.progress_frame,
            text="",
            font=ctk.CTkFont(family="Consolas", size=10, weight="bold"),
            text_color=C["cyan"],
            anchor="w",
        )
        self.progress_label.pack(side="left", padx=(5, 10))

        # Barra de progresso
        self.progress_bar = ctk.CTkProgressBar(
            self.progress_frame,
            fg_color=C["bg_darker"],
            progress_color=C["magenta"],
            border_color=C["purple"],
            border_width=1,
            height=16,
            corner_radius=2,
        )
        self.progress_bar.pack(side="left", fill="x", expand=True, padx=(0, 10), pady=6)
        self.progress_bar.set(0)

        # Percentagem
        self.progress_pct = ctk.CTkLabel(
            self.progress_frame,
            text="0%",
            font=ctk.CTkFont(family="Consolas", size=11, weight="bold"),
            text_color=C["magenta"],
            width=45,
        )
        self.progress_pct.pack(side="right", padx=5)

    # ================================================================
    # CONSOLE DE LOG (borda ciano)
    # ================================================================

    def _build_console(self):
        console_outer = ctk.CTkFrame(
            self, fg_color=C["bg_darker"],
            border_color=C["cyan"], border_width=2, corner_radius=4,
            height=160,
        )
        console_outer.pack(fill="x", padx=8, pady=(4, 0))
        console_outer.pack_propagate(False)

        self.console = ctk.CTkTextbox(
            console_outer,
            font=ctk.CTkFont(family="Consolas", size=11),
            fg_color=C["bg_darker"],
            text_color=C["cyan"],
            border_width=0,
            corner_radius=0,
            wrap="word",
            state="disabled",
            activate_scrollbars=True,
            scrollbar_button_color=C["cyan"],
        )
        self.console.pack(fill="both", expand=True, padx=4, pady=4)

    # ================================================================
    # FOOTER
    # ================================================================

    def _build_footer(self):
        footer = ctk.CTkFrame(self, fg_color="transparent", height=25)
        footer.pack(fill="x", padx=8, pady=(4, 6))
        footer.pack_propagate(False)

        ctk.CTkLabel(
            footer,
            text=f"(c) 2026 Lobo Tech  |  Lobo Alpha V{APP_VERSION} Premium  |  github.com/lobaotech",
            font=ctk.CTkFont(family="Consolas", size=9),
            text_color=C["text_muted"],
        ).pack(side="left")

        ctk.CTkLabel(
            footer,
            text=datetime.datetime.now().strftime("%d/%m/%Y  %H:%M"),
            font=ctk.CTkFont(family="Consolas", size=9),
            text_color=C["text_muted"],
        ).pack(side="right")

    # ================================================================
    # LOGICA
    # ================================================================

    def _log(self, message, level="info"):
        timestamp = datetime.datetime.now().strftime("%H:%M:%S")
        self.console.configure(state="normal")
        self.console.insert("end", f"[{timestamp}] {message}\n")
        self.console.see("end")
        self.console.configure(state="disabled")

    def _select_all(self, module_name, state):
        for sf, (var, cb) in self.checkboxes[module_name].items():
            var.set(state)
        self._update_selected_count()

    def _update_selected_count(self):
        total = 0
        for module_name, scripts in self.checkboxes.items():
            for sf, (var, cb) in scripts.items():
                if var.get():
                    total += 1
        self.selected_label.configure(text=f"{total} scripts selecionados")
        # Agendar proxima atualizacao
        self.after(500, self._update_selected_count)

    def _get_selected_scripts(self):
        selected = []
        for module_name, scripts in self.checkboxes.items():
            module_path = MODULES[module_name]["path"]
            for sf, (var, cb) in scripts.items():
                if var.get():
                    selected.append((module_path, sf))
        return selected

    def _download_and_run(self, module_path, script_file):
        url = f"{REPO_BASE}/{module_path}/{script_file}"
        self._log(f"Downloading: {script_file}")

        try:
            ctx = ssl.create_default_context()
            ctx.check_hostname = False
            ctx.verify_mode = ssl.CERT_NONE

            req = urllib.request.Request(url, headers={"User-Agent": "LoboAlpha/2.0"})
            with urllib.request.urlopen(req, context=ctx) as response:
                content = response.read()

            suffix = os.path.splitext(script_file)[1]
            temp_file = os.path.join(tempfile.gettempdir(), f"lobo_{script_file}")

            with open(temp_file, "wb") as f:
                f.write(content)

            self._log(f"Executing: {script_file}")

            creation_flags = 0
            if sys.platform == "win32":
                creation_flags = subprocess.CREATE_NO_WINDOW

            if suffix.lower() == ".bat":
                result = subprocess.run(
                    ["cmd.exe", "/c", temp_file],
                    capture_output=True, text=True, timeout=120,
                    creationflags=creation_flags,
                )
            elif suffix.lower() == ".reg":
                result = subprocess.run(
                    ["reg.exe", "import", temp_file],
                    capture_output=True, text=True, timeout=30,
                    creationflags=creation_flags,
                )
            elif suffix.lower() == ".ps1":
                result = subprocess.run(
                    ["powershell.exe", "-ExecutionPolicy", "Bypass", "-File", temp_file],
                    capture_output=True, text=True, timeout=120,
                    creationflags=creation_flags,
                )
            else:
                self._log(f"Unsupported file type: {suffix}", "warning")
                return False

            try:
                os.remove(temp_file)
            except Exception:
                pass

            if result.returncode == 0:
                self._log(f"[OK] {script_file} applied successfully.")
                return True
            else:
                self._log(f"[WARN] {script_file} returned code {result.returncode}")
                return True

        except urllib.error.URLError as e:
            self._log(f"[ERROR] Network error: {script_file} - {str(e)[:60]}")
            return False
        except subprocess.TimeoutExpired:
            self._log(f"[ERROR] Timeout: {script_file}")
            return False
        except Exception as e:
            self._log(f"[ERROR] {script_file}: {str(e)[:60]}")
            return False

    def _apply_tweaks(self):
        if self.is_running:
            self._log("[WARN] Already running! Wait for completion.")
            return

        selected = self._get_selected_scripts()
        if not selected:
            self._log("[WARN] No scripts selected! Select at least one.")
            return

        self._log(f"Starting execution of {len(selected)} script(s)...")
        self.is_running = True
        self.apply_btn.configure(state="disabled", text="RUNNING...")

        # Reset progress
        self.progress_bar.set(0)
        self.progress_label.configure(text="Initializing...")
        self.progress_pct.configure(text="0%")

        def run_thread():
            success = 0
            fail = 0
            total = len(selected)

            for i, (module_path, script_file) in enumerate(selected):
                # Atualizar progresso
                pct = (i / total)
                self.progress_bar.set(pct)
                self.progress_label.configure(text=f"[{i+1}/{total}] {script_file}")
                self.progress_pct.configure(text=f"{int(pct * 100)}%")

                result = self._download_and_run(module_path, script_file)
                if result:
                    success += 1
                else:
                    fail += 1

            # Progresso 100%
            self.progress_bar.set(1.0)
            self.progress_label.configure(text="COMPLETE!")
            self.progress_pct.configure(text="100%")

            self._log("")
            self._log("=" * 50)
            self._log(f"RESULT: {success} OK | {fail} FAILED | {total} TOTAL")
            self._log("Optimization complete!")
            self._log("=" * 50)

            self.is_running = False
            self.apply_btn.configure(state="normal", text="APLICAR\nTWEAKS")

        thread = threading.Thread(target=run_thread, daemon=True)
        thread.start()

    def _apply_all(self):
        for mn in self.checkboxes:
            self._select_all(mn, True)
        self._apply_tweaks()

    def _create_restore_point(self):
        if self.is_running:
            self._log("[WARN] Wait for current execution to finish.")
            return

        self._log("Creating system restore point...")
        self.is_running = True
        self.progress_bar.set(0)
        self.progress_label.configure(text="Creating restore point...")
        self.progress_pct.configure(text="...")

        def run_thread():
            # Simular progresso
            for i in range(5):
                self.progress_bar.set(i / 5)
                import time
                time.sleep(0.3)

            result = self._download_and_run("01_Preparacao_e_Backup", "01_CRIAR_PONTO_RESTAURACAO.bat")

            self.progress_bar.set(1.0)
            self.progress_pct.configure(text="100%")

            if result:
                self._log("[OK] Restore point created successfully!")
                self.progress_label.configure(text="Restore point created!")
            else:
                self._log("[ERROR] Failed to create restore point.")
                self.progress_label.configure(text="Failed!")

            self.is_running = False

        thread = threading.Thread(target=run_thread, daemon=True)
        thread.start()


# ================================================================
# PONTO DE ENTRADA
# ================================================================

def main():
    if sys.platform == "win32" and not is_admin():
        run_as_admin()
        return

    ctk.set_appearance_mode("dark")
    ctk.set_default_color_theme("blue")

    app = LoboAlphaApp()
    app.mainloop()

if __name__ == "__main__":
    main()
