# -*- coding: utf-8 -*-
"""
================================================================
  LOBO ALPHA V3.1 - PERFORMANCE EXTREME
  Toolkit de Otimizacao Windows - Premium Edition
  Criador: Bruno Lobo 2026 - Analista de Sistemas
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
import time
import concurrent.futures

# ================================================================
# CONFIGURACOES
# ================================================================

REPO_BASE = "https://raw.githubusercontent.com/lobaotech/otzremoto/main"
APP_VERSION = "3.1"
APP_NAME = "Lobo Alpha V3.1 - Performance Extreme"
CREATOR = "Bruno Lobo 2026 - Analista de Sistemas"

# Paleta Verde Ciano + Roxo com Degrade
C = {
    # Fundos
    "bg":           "#0a0a12",
    "bg_header":    "#0d0d18",
    "bg_card":      "#111120",
    "bg_card_alt":  "#14142a",
    "bg_hover":     "#1c1c35",
    "bg_input":     "#0e0e1a",
    "bg_terminal":  "#080810",
    "bg_tab":       "#0f0f20",
    "bg_tab_sel":   "#1a1a40",
    # Cores principais
    "cyan":         "#00FFB2",
    "cyan_light":   "#33FFCC",
    "cyan_dim":     "#00CC8E",
    "cyan_dark":    "#008866",
    "purple":       "#9933FF",
    "purple_light": "#BB66FF",
    "purple_dim":   "#7722CC",
    "purple_dark":  "#551199",
    # Texto
    "text":         "#E8E8F0",
    "text_sec":     "#9999BB",
    "text_dim":     "#555577",
    # Status
    "success":      "#00FF88",
    "warning":      "#FFBB33",
    "error":        "#FF4455",
    # Botoes
    "btn_apply":    "#00CC8E",
    "btn_apply_h":  "#00FFB2",
    "btn_restore":  "#9933FF",
    "btn_restore_h":"#BB66FF",
    "btn_all":      "#7722CC",
    "btn_all_h":    "#9933FF",
    "btn_stop":     "#FF4455",
    "btn_stop_h":   "#FF6677",
}

R = 6  # Raio de arredondamento

# ================================================================
# MODULOS DE OTIMIZACAO
# ================================================================

TABS = [
    {"key": "PERFORMANCE", "label": "Performance"},
    {"key": "GAMING",      "label": "Gaming"},
    {"key": "NETWORK",     "label": "Network"},
    {"key": "INPUT_LAG",   "label": "Input Lag"},
    {"key": "CLEANUP",     "label": "Cleanup"},
    {"key": "SYSTEM",      "label": "System"},
    {"key": "GPU",         "label": "GPU"},
    {"key": "PRIVACY",     "label": "Privacidade"},
]

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
    "INPUT_LAG": {
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
            ("DISM Restaurar Saude", "16_dism_restaurar_saude.bat"),
            ("SFC Scannow", "17_sfc_scannow.bat"),
        ],
    },
    "GPU": {
        "path": "03_GPU_e_Display",
        "scripts": [
            ("GPU Hardware Scheduling", "05_agendamento_gpu_hardware.bat"),
            ("Game DVR e Tela Cheia", "09_gamedvr_tela_cheia.bat"),
            ("Desativar Efeitos Visuais", "01_desativar_efeitos_visuais.bat"),
            ("Otimizar NVIDIA", "02_otimizar_nvidia.bat"),
            ("Otimizar AMD", "03_otimizar_amd.bat"),
        ],
    },
    "PRIVACY": {
        "path": "06_Privacidade_e_Telemetria",
        "scripts": [
            ("Desativar Telemetria", "01_desativar_telemetria.bat"),
            ("Desativar Cortana Telemetria", "02_desativar_cortana_telemetria.bat"),
            ("Desativar Rastreamento", "03_desativar_rastreamento.bat"),
            ("Desativar Feedback", "04_desativar_feedback.bat"),
        ],
    },
}

# ================================================================
# ADMIN CHECK
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
# APP PRINCIPAL - LAYOUT ANTIGO (Abas superiores)
# ================================================================

class LoboAlphaApp(ctk.CTk):
    def __init__(self):
        super().__init__()

        self.title(APP_NAME)
        self.geometry("1360x780")
        self.minsize(1000, 650)
        self.configure(fg_color=C["bg"])

        # Estado
        self.is_running = False
        self.cancel_flag = False
        self.current_process = None
        self.current_tab = "PERFORMANCE"
        self.checkboxes = {}

        # Admin check
        self.admin_ok = is_admin()

        # Layout: 4 linhas
        # Row 0: Header (nome + status)
        # Row 1: Abas superiores
        # Row 2: Conteudo (scripts esquerda + botoes direita)
        # Row 3: Barra progresso
        # Row 4: Terminal de execucao
        # Row 5: Barra inferior (4 botoes de acao)
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(0, weight=0)   # Header
        self.grid_rowconfigure(1, weight=0)   # Abas
        self.grid_rowconfigure(2, weight=1)   # Conteudo
        self.grid_rowconfigure(3, weight=0)   # Progresso
        self.grid_rowconfigure(4, weight=0, minsize=180)  # Terminal
        self.grid_rowconfigure(5, weight=0, minsize=50)   # Botoes

        self._build_header()
        self._build_tabs()
        self._build_content()
        self._build_progress()
        self._build_terminal()
        self._build_action_bar()

        # Inicializar
        self._select_tab("PERFORMANCE")

        # Log inicial
        self._log(f"{APP_NAME} inicializado.")
        self._log(f"Criador: {CREATOR}")
        if self.admin_ok:
            self._log_ok("Executando como Administrador.")
        else:
            self._log_warn("SEM privilegios de administrador!")
        self._log("Pronto. Selecione os tweaks e clique em Aplicar.")

    # ============================================================
    # HEADER
    # ============================================================

    def _build_header(self):
        header = ctk.CTkFrame(self, fg_color=C["bg_header"], corner_radius=0, height=40)
        header.grid(row=0, column=0, sticky="ew")
        header.grid_propagate(False)
        header.grid_columnconfigure(1, weight=1)

        # Logo + Nome
        logo_frame = ctk.CTkFrame(header, fg_color="transparent")
        logo_frame.grid(row=0, column=0, padx=12, pady=6, sticky="w")

        ctk.CTkLabel(
            logo_frame, text="LA",
            font=ctk.CTkFont(family="Consolas", size=13, weight="bold"),
            text_color=C["cyan"], fg_color=C["purple_dark"],
            corner_radius=4, width=28, height=28,
        ).pack(side="left", padx=(0, 8))

        ctk.CTkLabel(
            logo_frame, text="LOBO ALPHA V3.1",
            font=ctk.CTkFont(family="Consolas", size=13, weight="bold"),
            text_color=C["cyan"],
        ).pack(side="left")

        ctk.CTkLabel(
            logo_frame, text="PERFORMANCE EXTREME",
            font=ctk.CTkFont(family="Consolas", size=9),
            text_color=C["purple_light"],
        ).pack(side="left", padx=(6, 0))

        # Status admin
        status_text = "ADMIN" if self.admin_ok else "USER"
        status_color = C["success"] if self.admin_ok else C["warning"]
        ctk.CTkLabel(
            header, text=f" {status_text} ",
            font=ctk.CTkFont(family="Consolas", size=9, weight="bold"),
            text_color=status_color,
            fg_color=C["bg_card"],
            corner_radius=3,
        ).grid(row=0, column=2, padx=12, pady=6, sticky="e")

    # ============================================================
    # ABAS SUPERIORES
    # ============================================================

    def _build_tabs(self):
        tabs_frame = ctk.CTkFrame(self, fg_color=C["bg_header"], corner_radius=0, height=32)
        tabs_frame.grid(row=1, column=0, sticky="ew")
        tabs_frame.grid_propagate(False)

        inner = ctk.CTkFrame(tabs_frame, fg_color="transparent")
        inner.pack(fill="x", padx=8, pady=3)

        self.tab_buttons = {}
        for tab in TABS:
            btn = ctk.CTkButton(
                inner,
                text=tab["label"],
                font=ctk.CTkFont(family="Consolas", size=10),
                fg_color=C["bg_tab"],
                hover_color=C["bg_hover"],
                text_color=C["text_sec"],
                height=24,
                corner_radius=4,
                border_width=1,
                border_color=C["purple_dark"],
                command=lambda k=tab["key"]: self._select_tab(k),
            )
            btn.pack(side="left", padx=2, expand=True, fill="x")
            self.tab_buttons[tab["key"]] = btn

    def _select_tab(self, key):
        self.current_tab = key
        for k, btn in self.tab_buttons.items():
            if k == key:
                btn.configure(
                    fg_color=C["bg_tab_sel"],
                    text_color=C["cyan"],
                    border_color=C["cyan_dim"],
                )
            else:
                btn.configure(
                    fg_color=C["bg_tab"],
                    text_color=C["text_sec"],
                    border_color=C["purple_dark"],
                )
        self._populate_scripts(key)

    # ============================================================
    # CONTEUDO (Scripts + Botoes laterais)
    # ============================================================

    def _build_content(self):
        content = ctk.CTkFrame(self, fg_color=C["bg"], corner_radius=0)
        content.grid(row=2, column=0, sticky="nsew")
        content.grid_columnconfigure(0, weight=1)
        content.grid_columnconfigure(1, weight=0)
        content.grid_rowconfigure(0, weight=0)
        content.grid_rowconfigure(1, weight=1)

        # Header de scripts (contagem + marcar/desmarcar)
        scripts_header = ctk.CTkFrame(content, fg_color=C["bg_card"], height=30, corner_radius=0)
        scripts_header.grid(row=0, column=0, columnspan=2, sticky="ew")
        scripts_header.grid_propagate(False)
        scripts_header.grid_columnconfigure(0, weight=1)

        self.scripts_count_label = ctk.CTkLabel(
            scripts_header, text="0 scripts disponiveis",
            font=ctk.CTkFont(family="Consolas", size=10),
            text_color=C["text_sec"],
        )
        self.scripts_count_label.grid(row=0, column=0, padx=10, sticky="w")

        btn_frame = ctk.CTkFrame(scripts_header, fg_color="transparent")
        btn_frame.grid(row=0, column=1, padx=6, sticky="e")

        ctk.CTkButton(
            btn_frame, text="Marcar Tudo",
            font=ctk.CTkFont(family="Consolas", size=9),
            fg_color=C["cyan_dark"], hover_color=C["cyan_dim"],
            text_color=C["bg"], width=75, height=22, corner_radius=3,
            command=self._select_all,
        ).pack(side="left", padx=2)

        ctk.CTkButton(
            btn_frame, text="Desmarcar",
            font=ctk.CTkFont(family="Consolas", size=9),
            fg_color=C["bg_hover"], hover_color=C["bg_card_alt"],
            text_color=C["text_sec"], width=65, height=22, corner_radius=3,
            command=self._deselect_all,
        ).pack(side="left", padx=2)

        # Scrollable area para scripts
        self.scripts_scroll = ctk.CTkScrollableFrame(
            content,
            fg_color=C["bg"],
            scrollbar_button_color=C["purple_dark"],
            scrollbar_button_hover_color=C["purple_dim"],
        )
        self.scripts_scroll.grid(row=1, column=0, sticky="nsew", padx=4, pady=2)
        self.scripts_scroll.grid_columnconfigure(0, weight=1)

        # Painel lateral direito (botoes de acao rapida)
        self.side_panel = ctk.CTkFrame(
            content, fg_color=C["bg_header"], corner_radius=0, width=180,
            border_width=1, border_color=C["purple_dark"],
        )
        self.side_panel.grid(row=1, column=1, sticky="nsew", padx=(0, 0))
        self.side_panel.grid_propagate(False)

        # Botao Aplicar Tweaks (grande)
        self.apply_btn = ctk.CTkButton(
            self.side_panel, text="APLICAR\nTWEAKS",
            font=ctk.CTkFont(family="Consolas", size=12, weight="bold"),
            fg_color=C["btn_apply"], hover_color=C["btn_apply_h"],
            text_color=C["bg"],
            height=70, corner_radius=R,
            command=self._apply_tweaks,
        )
        self.apply_btn.pack(fill="x", padx=8, pady=(12, 4))

        self.selected_label = ctk.CTkLabel(
            self.side_panel, text="0 selecionados",
            font=ctk.CTkFont(family="Consolas", size=9),
            text_color=C["text_dim"],
        )
        self.selected_label.pack(pady=(0, 8))

        # Botao Restore Point
        self.restore_btn = ctk.CTkButton(
            self.side_panel, text="RESTORE\nPOINT",
            font=ctk.CTkFont(family="Consolas", size=11, weight="bold"),
            fg_color=C["btn_restore"], hover_color=C["btn_restore_h"],
            text_color="#FFFFFF",
            height=55, corner_radius=R,
            command=self._create_restore_point,
        )
        self.restore_btn.pack(fill="x", padx=8, pady=4)

        # Botao Aplicar Tudo
        self.all_btn = ctk.CTkButton(
            self.side_panel, text="APLICAR\nTUDO",
            font=ctk.CTkFont(family="Consolas", size=11, weight="bold"),
            fg_color=C["btn_all"], hover_color=C["btn_all_h"],
            text_color="#FFFFFF",
            height=55, corner_radius=R,
            command=self._apply_all,
        )
        self.all_btn.pack(fill="x", padx=8, pady=4)

        # Botao Parar
        self.stop_btn = ctk.CTkButton(
            self.side_panel, text="PARAR",
            font=ctk.CTkFont(family="Consolas", size=11, weight="bold"),
            fg_color=C["btn_stop"], hover_color=C["btn_stop_h"],
            text_color="#FFFFFF",
            height=40, corner_radius=R,
            state="disabled",
            command=self._stop_execution,
        )
        self.stop_btn.pack(fill="x", padx=8, pady=4)

        # Spacer
        spacer = ctk.CTkFrame(self.side_panel, fg_color="transparent")
        spacer.pack(fill="both", expand=True)

        # Info
        ctk.CTkLabel(
            self.side_panel, text="LOBO TECH",
            font=ctk.CTkFont(family="Consolas", size=10, weight="bold"),
            text_color=C["purple_light"],
        ).pack(pady=(0, 2))

        ctk.CTkLabel(
            self.side_panel, text=f"v{APP_VERSION} // PREMIUM",
            font=ctk.CTkFont(family="Consolas", size=8),
            text_color=C["text_dim"],
        ).pack(pady=(0, 8))

    def _populate_scripts(self, category):
        for widget in self.scripts_scroll.winfo_children():
            widget.destroy()

        if category not in MODULES:
            self.scripts_count_label.configure(text="Categoria nao disponivel")
            return

        mod = MODULES[category]
        scripts = mod["scripts"]
        path = mod["path"]

        self.scripts_count_label.configure(text=f"{len(scripts)} scripts disponiveis")

        if category not in self.checkboxes:
            self.checkboxes[category] = []
            for name, sfile in scripts:
                var = ctk.BooleanVar(value=False)
                self.checkboxes[category].append((var, path, sfile, name))

        for i, (var, mp, sf, name) in enumerate(self.checkboxes[category]):
            row_bg = C["bg_card"] if i % 2 == 0 else C["bg"]

            row = ctk.CTkFrame(
                self.scripts_scroll, fg_color=row_bg,
                corner_radius=3, height=28,
            )
            row.pack(fill="x", pady=1, padx=2)
            row.pack_propagate(False)
            row.grid_columnconfigure(1, weight=1)

            cb = ctk.CTkCheckBox(
                row, text="",
                variable=var,
                width=16, height=16,
                checkbox_width=14, checkbox_height=14,
                corner_radius=3,
                fg_color=C["cyan"],
                hover_color=C["cyan_dim"],
                border_color=C["purple_dim"],
                border_width=1,
                command=self._update_selected_count,
            )
            cb.grid(row=0, column=0, padx=(6, 4), pady=5)

            ctk.CTkLabel(
                row, text=name,
                font=ctk.CTkFont(family="Consolas", size=11),
                text_color=C["text"],
                anchor="w",
            ).grid(row=0, column=1, sticky="w")

            ctk.CTkLabel(
                row, text=sf,
                font=ctk.CTkFont(family="Consolas", size=9),
                text_color=C["text_dim"],
                anchor="e",
            ).grid(row=0, column=2, padx=(4, 8), sticky="e")

    def _update_selected_count(self):
        count = len(self._get_selected())
        self.selected_label.configure(text=f"{count} selecionados")

    def _select_all(self):
        cat = self.current_tab
        if cat in self.checkboxes:
            for var, _, _, _ in self.checkboxes[cat]:
                var.set(True)
        self._update_selected_count()

    def _deselect_all(self):
        cat = self.current_tab
        if cat in self.checkboxes:
            for var, _, _, _ in self.checkboxes[cat]:
                var.set(False)
        self._update_selected_count()

    def _get_selected(self):
        sel = []
        for cat, items in self.checkboxes.items():
            for var, mp, sf, name in items:
                if var.get():
                    sel.append((mp, sf))
        return sel

    def _get_all_scripts(self):
        all_scripts = []
        for cat_key, mod in MODULES.items():
            for name, sf in mod["scripts"]:
                all_scripts.append((mod["path"], sf))
        return all_scripts

    # ============================================================
    # BARRA DE PROGRESSO
    # ============================================================

    def _build_progress(self):
        prog_frame = ctk.CTkFrame(self, fg_color=C["bg_card"], corner_radius=0, height=24)
        prog_frame.grid(row=3, column=0, sticky="ew")
        prog_frame.grid_propagate(False)
        prog_frame.grid_columnconfigure(1, weight=1)

        self.progress_label = ctk.CTkLabel(
            prog_frame, text="Aguardando...",
            font=ctk.CTkFont(family="Consolas", size=9),
            text_color=C["text_sec"],
        )
        self.progress_label.grid(row=0, column=0, padx=8, sticky="w")

        self.progress_bar = ctk.CTkProgressBar(
            prog_frame,
            fg_color=C["bg_input"],
            progress_color=C["cyan"],
            height=8, corner_radius=4,
        )
        self.progress_bar.grid(row=0, column=1, padx=4, sticky="ew", pady=8)
        self.progress_bar.set(0)

        self.progress_pct = ctk.CTkLabel(
            prog_frame, text="0%",
            font=ctk.CTkFont(family="Consolas", size=9, weight="bold"),
            text_color=C["cyan"],
            width=32,
        )
        self.progress_pct.grid(row=0, column=2, padx=4)

    # ============================================================
    # TERMINAL DE EXECUCAO (embaixo)
    # ============================================================

    def _build_terminal(self):
        term_container = ctk.CTkFrame(
            self, fg_color=C["bg_terminal"], corner_radius=0,
            border_width=1, border_color=C["purple_dark"],
        )
        term_container.grid(row=4, column=0, sticky="nsew", padx=4, pady=(2, 0))
        term_container.grid_rowconfigure(1, weight=1)
        term_container.grid_columnconfigure(0, weight=1)

        # Header do terminal
        term_header = ctk.CTkFrame(term_container, fg_color=C["bg_card"], height=22, corner_radius=0)
        term_header.grid(row=0, column=0, sticky="ew")
        term_header.grid_propagate(False)

        ctk.CTkLabel(
            term_header, text="  TERMINAL DE EXECUCAO",
            font=ctk.CTkFont(family="Consolas", size=9, weight="bold"),
            text_color=C["cyan"],
        ).pack(side="left", padx=6, pady=2)

        # Console
        self.console = ctk.CTkTextbox(
            term_container,
            fg_color=C["bg_terminal"],
            text_color=C["cyan"],
            font=ctk.CTkFont(family="Consolas", size=9),
            corner_radius=0,
            border_width=0,
            wrap="word",
            state="disabled",
        )
        self.console.grid(row=1, column=0, sticky="nsew", padx=4, pady=2)

        # Tags de cor
        self.console.configure(state="normal")
        self.console._textbox.tag_configure("ok", foreground=C["success"])
        self.console._textbox.tag_configure("warn", foreground=C["warning"])
        self.console._textbox.tag_configure("err", foreground=C["error"])
        self.console._textbox.tag_configure("output", foreground="#88AACC")
        self.console._textbox.tag_configure("dim", foreground=C["text_dim"])
        self.console.configure(state="disabled")

    # ============================================================
    # BARRA INFERIOR (4 botoes de acao)
    # ============================================================

    def _build_action_bar(self):
        bar = ctk.CTkFrame(
            self, fg_color=C["bg_header"], corner_radius=0, height=50,
            border_width=1, border_color=C["purple_dark"],
        )
        bar.grid(row=5, column=0, sticky="sew")
        bar.grid_propagate(False)
        bar.grid_columnconfigure(4, weight=1)

        # Botao Restore Point
        ctk.CTkButton(
            bar, text="Ponto de Restauracao",
            font=ctk.CTkFont(family="Consolas", size=10, weight="bold"),
            fg_color=C["btn_restore"], hover_color=C["btn_restore_h"],
            text_color="#FFFFFF",
            height=34, corner_radius=R, width=170,
            command=self._create_restore_point,
        ).grid(row=0, column=0, padx=(10, 4), pady=8)

        # Botao Aplicar Selecionados
        ctk.CTkButton(
            bar, text="Aplicar Selecionados",
            font=ctk.CTkFont(family="Consolas", size=10, weight="bold"),
            fg_color=C["btn_apply"], hover_color=C["btn_apply_h"],
            text_color=C["bg"],
            height=34, corner_radius=R, width=170,
            command=self._apply_tweaks,
        ).grid(row=0, column=1, padx=4, pady=8)

        # Botao Aplicar Tudo
        ctk.CTkButton(
            bar, text="Aplicar Tudo",
            font=ctk.CTkFont(family="Consolas", size=10, weight="bold"),
            fg_color=C["btn_all"], hover_color=C["btn_all_h"],
            text_color="#FFFFFF",
            height=34, corner_radius=R, width=130,
            command=self._apply_all,
        ).grid(row=0, column=2, padx=4, pady=8)

        # Botao Parar
        self.stop_btn_bar = ctk.CTkButton(
            bar, text="PARAR",
            font=ctk.CTkFont(family="Consolas", size=10, weight="bold"),
            fg_color=C["btn_stop"], hover_color=C["btn_stop_h"],
            text_color="#FFFFFF",
            height=34, corner_radius=R, width=100,
            state="disabled",
            command=self._stop_execution,
        )
        self.stop_btn_bar.grid(row=0, column=3, padx=4, pady=8)

        # Spacer
        ctk.CTkFrame(bar, fg_color="transparent").grid(row=0, column=4, sticky="ew")

        # Info
        ctk.CTkLabel(
            bar, text=f"(c) 2026 Bruno Lobo  |  {APP_NAME}  |  github.com/lobaotech",
            font=ctk.CTkFont(family="Consolas", size=8),
            text_color=C["text_dim"],
        ).grid(row=0, column=5, padx=10, sticky="e")

    # ============================================================
    # LOGGING
    # ============================================================

    def _log(self, msg, tag=None):
        ts = datetime.datetime.now().strftime("%H:%M:%S")
        self.console.configure(state="normal")
        if tag:
            self.console._textbox.insert("end", f"[{ts}] {msg}\n", tag)
        else:
            self.console._textbox.insert("end", f"[{ts}] {msg}\n")
        self.console._textbox.see("end")
        self.console.configure(state="disabled")

    def _log_ok(self, msg):
        self._log(f"[OK] {msg}", "ok")

    def _log_warn(self, msg):
        self._log(f"[WARN] {msg}", "warn")

    def _log_err(self, msg):
        self._log(f"[ERRO] {msg}", "err")

    def _log_output(self, msg):
        self._log(f"  | {msg}", "output")

    # ============================================================
    # DOWNLOAD & EXECUCAO
    # ============================================================

    def _download_script(self, module_path, script_file):
        cache_dir = os.path.join(tempfile.gettempdir(), "lobo_cache")
        os.makedirs(cache_dir, exist_ok=True)
        temp_file = os.path.join(cache_dir, f"{module_path.replace('/', '_')}_{script_file}")

        if os.path.exists(temp_file) and os.path.getsize(temp_file) > 0:
            return temp_file

        url = f"{REPO_BASE}/{module_path}/{script_file}"
        try:
            ctx = ssl.create_default_context()
            ctx.check_hostname = False
            ctx.verify_mode = ssl.CERT_NONE
            req = urllib.request.Request(url, headers={"User-Agent": "LoboAlpha/3.1"})
            with urllib.request.urlopen(req, context=ctx, timeout=10) as resp:
                content = resp.read()
            with open(temp_file, "wb") as f:
                f.write(content)
            return temp_file
        except Exception:
            return None

    def _batch_download(self, scripts_list):
        self._log(f"Baixando {len(scripts_list)} scripts em paralelo...")
        results = {}
        with concurrent.futures.ThreadPoolExecutor(max_workers=10) as pool:
            futures = {}
            for mp, sf in scripts_list:
                fut = pool.submit(self._download_script, mp, sf)
                futures[fut] = (mp, sf)
            done_count = 0
            for fut in concurrent.futures.as_completed(futures):
                if self.cancel_flag:
                    break
                mp, sf = futures[fut]
                path = fut.result()
                results[(mp, sf)] = path
                done_count += 1
                if path:
                    self._log_ok(f"Download: {sf}")
                else:
                    self._log_err(f"Falha download: {sf}")
                dl_pct = done_count / len(scripts_list) * 0.25
                self.progress_bar.set(dl_pct)
                self.progress_pct.configure(text=f"{int(dl_pct*100)}%")
        return results

    def _run_script(self, temp_file, script_file):
        suffix = os.path.splitext(script_file)[1].lower()

        if suffix in (".bat", ".cmd"):
            cmd = ["cmd.exe", "/c", temp_file]
        elif suffix == ".reg":
            cmd = ["reg.exe", "import", temp_file]
        elif suffix == ".ps1":
            cmd = ["powershell.exe", "-ExecutionPolicy", "Bypass", "-File", temp_file]
        else:
            self._log_warn(f"Tipo nao suportado: {suffix}")
            return False

        creation_flags = 0
        if sys.platform == "win32":
            creation_flags = subprocess.CREATE_NO_WINDOW

        try:
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                bufsize=1,
                creationflags=creation_flags,
            )
            self.current_process = process

            start_time = time.time()
            for line in iter(process.stdout.readline, ""):
                if self.cancel_flag:
                    process.kill()
                    process.stdout.close()
                    self._log_warn(f"Cancelado: {script_file}")
                    return False
                line = line.rstrip()
                if line:
                    self._log_output(line)
                if time.time() - start_time > 15:
                    self._log_warn(f"Timeout 15s: {script_file} - avancando...")
                    process.kill()
                    process.stdout.close()
                    self.current_process = None
                    return True

            process.stdout.close()
            return_code = process.wait(timeout=5)
            self.current_process = None

            if return_code == 0:
                self._log_ok(f"{script_file} aplicado!")
            else:
                self._log_warn(f"{script_file} codigo {return_code}")
            return True

        except subprocess.TimeoutExpired:
            self._log_warn(f"Timeout: {script_file}")
            try:
                process.kill()
            except Exception:
                pass
            self.current_process = None
            return True
        except Exception as e:
            self._log_err(f"{script_file}: {str(e)[:60]}")
            self.current_process = None
            return False

    # ============================================================
    # ACOES
    # ============================================================

    def _set_running(self, running):
        self.is_running = running
        if running:
            self.cancel_flag = False
            self.apply_btn.configure(state="disabled", text="EXECUTANDO...")
            self.all_btn.configure(state="disabled")
            self.restore_btn.configure(state="disabled")
            self.stop_btn.configure(state="normal")
            self.stop_btn_bar.configure(state="normal")
        else:
            self.apply_btn.configure(state="normal", text="APLICAR\nTWEAKS")
            self.all_btn.configure(state="normal")
            self.restore_btn.configure(state="normal")
            self.stop_btn.configure(state="disabled")
            self.stop_btn_bar.configure(state="disabled")

    def _stop_execution(self):
        self.cancel_flag = True
        if self.current_process:
            try:
                self.current_process.kill()
            except Exception:
                pass
        self._log_warn("EXECUCAO CANCELADA PELO USUARIO!")

    def _execute_scripts(self, scripts_list):
        start = time.time()
        total = len(scripts_list)

        # Fase 1: Download paralelo
        downloaded = self._batch_download(scripts_list)
        if self.cancel_flag:
            self._log_warn("Downloads cancelados.")
            self._set_running(False)
            return

        dl_ok = sum(1 for v in downloaded.values() if v)
        self._log(f"Downloads: {dl_ok}/{total} em {time.time()-start:.1f}s")
        self._log("")

        # Fase 2: Execucao sequencial
        self._log("Executando scripts...")
        ok = 0
        fail = 0
        for i, (mp, sf) in enumerate(scripts_list):
            if self.cancel_flag:
                self._log_warn("Execucao cancelada.")
                break

            pct = 0.25 + (i / total) * 0.75
            self.progress_bar.set(pct)
            self.progress_label.configure(text=f"[{i+1}/{total}] {sf}")
            self.progress_pct.configure(text=f"{int(pct*100)}%")

            temp_file = downloaded.get((mp, sf))
            if temp_file and os.path.exists(temp_file):
                self._log(f"Executando: {sf}")
                if self._run_script(temp_file, sf):
                    ok += 1
                else:
                    fail += 1
            else:
                self._log_err(f"Nao encontrado: {sf}")
                fail += 1

        elapsed = time.time() - start
        self.progress_bar.set(1.0)
        self.progress_label.configure(text="Concluido!")
        self.progress_pct.configure(text="100%")

        self._log("")
        self._log("=" * 45)
        self._log(f"RESULTADO: {ok} OK | {fail} FALHAS | {total} TOTAL")
        self._log(f"Tempo total: {elapsed:.1f} segundos")
        if self.cancel_flag:
            self._log_warn("Execucao foi interrompida pelo usuario.")
        elif fail == 0:
            self._log_ok("Todas as otimizacoes aplicadas!")
        else:
            self._log_warn(f"{fail} script(s) falharam.")
        self._log("=" * 45)

        self._set_running(False)

    def _apply_tweaks(self):
        if self.is_running:
            self._log_warn("Ja existe uma execucao em andamento!")
            return

        selected = self._get_selected()
        if not selected:
            self._log_warn("Nenhum script selecionado!")
            return

        self._log(f"Iniciando {len(selected)} script(s) selecionados...")
        self._set_running(True)
        self.progress_bar.set(0)
        self.progress_label.configure(text="Preparando...")
        self.progress_pct.configure(text="0%")

        threading.Thread(target=self._execute_scripts, args=(selected,), daemon=True).start()

    def _apply_all(self):
        if self.is_running:
            self._log_warn("Ja existe uma execucao em andamento!")
            return

        all_scripts = self._get_all_scripts()
        self._log(f"APLICAR TUDO: {len(all_scripts)} scripts de todas as categorias...")
        self._set_running(True)
        self.progress_bar.set(0)
        self.progress_label.configure(text="Preparando...")
        self.progress_pct.configure(text="0%")

        threading.Thread(target=self._execute_scripts, args=(all_scripts,), daemon=True).start()

    def _create_restore_point(self):
        if self.is_running:
            self._log_warn("Aguarde a execucao atual terminar.")
            return

        self._log("Criando ponto de restauracao...")
        self._set_running(True)
        self.progress_bar.set(0.2)
        self.progress_label.configure(text="Criando restore point...")

        def worker():
            temp_file = self._download_script("01_Preparacao_e_Backup", "01_CRIAR_PONTO_RESTAURACAO.bat")
            self.progress_bar.set(0.5)

            if temp_file:
                self._log("Executando restore point...")
                ok = self._run_script(temp_file, "01_CRIAR_PONTO_RESTAURACAO.bat")
            else:
                ok = False

            self.progress_bar.set(1.0)
            self.progress_pct.configure(text="100%")

            if ok:
                self._log_ok("Ponto de restauracao criado!")
                self.progress_label.configure(text="Restore point criado!")
            else:
                self._log_err("Falha ao criar ponto de restauracao.")
                self.progress_label.configure(text="Falha!")

            self._set_running(False)

        threading.Thread(target=worker, daemon=True).start()


# ================================================================
# MAIN
# ================================================================

def main():
    ctk.set_appearance_mode("dark")
    ctk.set_default_color_theme("dark-blue")
    app = LoboAlphaApp()
    app.mainloop()

if __name__ == "__main__":
    main()
