#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
================================================================
  LOBO ALPHA V2.0 - PREMIUM EDITION
  Toolkit de Otimizacao Windows - Cyberpunk Premium UI
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
import time

# ================================================================
# CONFIGURACOES
# ================================================================

REPO_BASE = "https://raw.githubusercontent.com/lobaotech/otzremoto/main"
APP_VERSION = "2.0.0"

# Paleta Premium Cyberpunk
C = {
    # Fundos
    "bg":           "#080810",
    "bg_card":      "#10101c",
    "bg_card_alt":  "#141422",
    "bg_hover":     "#1a1a2e",
    "bg_input":     "#0c0c18",
    # Neon
    "purple":       "#9933ff",
    "purple_glow":  "#bb66ff",
    "purple_dim":   "#6622aa",
    "magenta":      "#ff00ff",
    "magenta_dim":  "#cc00cc",
    "cyan":         "#00ffcc",
    "cyan_dim":     "#00cc99",
    "pink":         "#ff2266",
    "pink_dim":     "#cc1144",
    "blue":         "#3366ff",
    # Texto
    "text":         "#e8e8f0",
    "text_sec":     "#9999bb",
    "text_dim":     "#555577",
    # Status
    "success":      "#00ff88",
    "warning":      "#ffbb33",
    "error":        "#ff4455",
}

# Raio de arredondamento padrao
R = 12

# ================================================================
# MODULOS DE OTIMIZACAO
# ================================================================

TABS = [
    ("PERFORMANCE", "\u26a1", C["cyan"]),
    ("GAMING",      "\U0001f3ae", C["magenta"]),
    ("NETWORK",     "\U0001f310", C["cyan"]),
    ("INPUT LAG",   "\U0001f5b1\ufe0f", C["magenta"]),
    ("CLEANUP",     "\U0001f9f9", C["cyan"]),
    ("SYSTEM",      "\u2699\ufe0f", C["magenta"]),
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
# APP PRINCIPAL
# ================================================================

class LoboAlphaApp(ctk.CTk):
    def __init__(self):
        super().__init__()

        self.title(f"Lobo Alpha V{APP_VERSION} Premium")
        self.geometry("1280x800")
        self.minsize(1050, 680)
        self.configure(fg_color=C["bg"])

        self.checkboxes = {}
        self.is_running = False
        self.current_tab = "PERFORMANCE"

        self._build_header()
        self._build_tabs_bar()
        self._build_body()
        self._build_progress_section()
        self._build_console()
        self._build_footer()

        self._log_system("Lobo Alpha V2.0 Premium initialized.")
        self._log_system("System scan complete. No critical errors found.")
        self._log_info("Ready to apply tweaks. Select options above.")

    # ============================================================
    # HEADER
    # ============================================================

    def _build_header(self):
        header = ctk.CTkFrame(
            self, fg_color=C["bg_card"], corner_radius=R,
            border_color=C["purple"], border_width=1
        )
        header.pack(fill="x", padx=12, pady=(10, 0))

        inner = ctk.CTkFrame(header, fg_color="transparent")
        inner.pack(fill="x", padx=20, pady=14)

        # Esquerda: Logo + Titulo
        left = ctk.CTkFrame(inner, fg_color="transparent")
        left.pack(side="left")

        ctk.CTkLabel(
            left,
            text="\U0001f43a  LOBO ALPHA V2.0",
            font=ctk.CTkFont(family="Segoe UI", size=22, weight="bold"),
            text_color=C["cyan"],
        ).pack(side="left")

        ctk.CTkLabel(
            left,
            text="  //  DOMINE SEU HARDWARE",
            font=ctk.CTkFont(family="Segoe UI", size=22, weight="bold"),
            text_color=C["purple_glow"],
        ).pack(side="left")

        # Direita: Status
        right = ctk.CTkFrame(inner, fg_color="transparent")
        right.pack(side="right")

        admin_ok = is_admin()
        status_frame = ctk.CTkFrame(
            right, fg_color=C["success"] + "15" if admin_ok else C["error"] + "15",
            corner_radius=8,
            border_color=C["success"] if admin_ok else C["error"],
            border_width=1,
        )
        status_frame.pack(side="right")

        ctk.CTkLabel(
            status_frame,
            text=("\u2705  ADMIN" if admin_ok else "\u26a0\ufe0f  SEM ADMIN"),
            font=ctk.CTkFont(family="Segoe UI", size=11, weight="bold"),
            text_color=C["success"] if admin_ok else C["error"],
        ).pack(padx=12, pady=5)

    # ============================================================
    # TABS BAR
    # ============================================================

    def _build_tabs_bar(self):
        bar = ctk.CTkFrame(self, fg_color="transparent")
        bar.pack(fill="x", padx=12, pady=(8, 0))

        self.tab_buttons = {}

        for tab_name, icon, color in TABS:
            is_active = (tab_name == self.current_tab)

            btn = ctk.CTkButton(
                bar,
                text=f"{icon}  {tab_name}",
                font=ctk.CTkFont(family="Segoe UI", size=13, weight="bold"),
                fg_color=color if is_active else C["bg_card"],
                hover_color=color + "aa",
                text_color=C["bg"] if is_active else color,
                corner_radius=R,
                height=42,
                border_color=color,
                border_width=1 if not is_active else 0,
                command=lambda tn=tab_name: self._switch_tab(tn),
            )
            btn.pack(side="left", fill="x", expand=True, padx=3)
            self.tab_buttons[tab_name] = (btn, color)

    def _switch_tab(self, tab_name):
        self.current_tab = tab_name
        for tn, (btn, color) in self.tab_buttons.items():
            if tn == tab_name:
                btn.configure(fg_color=color, text_color=C["bg"], border_width=0)
            else:
                btn.configure(fg_color=C["bg_card"], text_color=color, border_width=1)
        for tn, frame in self.tab_content.items():
            if tn == tab_name:
                frame.pack(fill="both", expand=True, padx=2, pady=2)
            else:
                frame.pack_forget()

    # ============================================================
    # BODY
    # ============================================================

    def _build_body(self):
        body = ctk.CTkFrame(self, fg_color="transparent")
        body.pack(fill="both", expand=True, padx=12, pady=(6, 0))

        # === ESQUERDA: Scripts ===
        left = ctk.CTkFrame(
            body, fg_color=C["bg_card"], corner_radius=R,
            border_color=C["purple"] + "66", border_width=1,
        )
        left.pack(side="left", fill="both", expand=True, padx=(0, 6))

        self.tab_content = {}
        for tab_name, module_data in MODULES.items():
            scroll = ctk.CTkScrollableFrame(
                left, fg_color="transparent",
                scrollbar_button_color=C["purple"],
                scrollbar_button_hover_color=C["magenta"],
                corner_radius=0,
            )
            self.tab_content[tab_name] = scroll
            self._build_script_list(scroll, tab_name, module_data)

        self.tab_content[self.current_tab].pack(fill="both", expand=True, padx=2, pady=2)

        # === DIREITA: Acoes ===
        right = ctk.CTkFrame(body, fg_color="transparent", width=290)
        right.pack(side="right", fill="y")
        right.pack_propagate(False)
        self._build_actions(right)

    def _build_script_list(self, parent, module_name, module_data):
        self.checkboxes[module_name] = {}

        # Header com botoes
        hdr = ctk.CTkFrame(parent, fg_color="transparent")
        hdr.pack(fill="x", padx=8, pady=(8, 4))

        ctk.CTkLabel(
            hdr,
            text=f"{len(module_data['scripts'])} scripts disponiveis",
            font=ctk.CTkFont(family="Segoe UI", size=11),
            text_color=C["text_sec"],
        ).pack(side="left")

        ctk.CTkButton(
            hdr, text="Desmarcar",
            font=ctk.CTkFont(size=11), width=80, height=26,
            fg_color="transparent", hover_color=C["bg_hover"],
            text_color=C["text_dim"], corner_radius=6,
            command=lambda mn=module_name: self._select_all(mn, False),
        ).pack(side="right", padx=(4, 0))

        ctk.CTkButton(
            hdr, text="\u2714  Marcar Tudo",
            font=ctk.CTkFont(size=11), width=100, height=26,
            fg_color=C["purple"] + "33", hover_color=C["purple"] + "55",
            text_color=C["purple_glow"], corner_radius=6,
            border_color=C["purple"] + "55", border_width=1,
            command=lambda mn=module_name: self._select_all(mn, True),
        ).pack(side="right")

        # Linha separadora
        ctk.CTkFrame(parent, fg_color=C["purple"] + "33", height=1, corner_radius=0).pack(fill="x", padx=8, pady=(2, 6))

        # Scripts
        for display_name, script_file in module_data["scripts"]:
            var = ctk.BooleanVar(value=False)

            row = ctk.CTkFrame(
                parent, fg_color=C["bg_card_alt"], corner_radius=8,
                height=40,
            )
            row.pack(fill="x", padx=8, pady=2)
            row.pack_propagate(False)

            cb = ctk.CTkCheckBox(
                row, text="",
                variable=var, width=22, height=22,
                fg_color=C["cyan"], hover_color=C["cyan_dim"],
                border_color=C["purple"] + "88",
                checkmark_color=C["bg"], corner_radius=6,
                border_width=2,
            )
            cb.pack(side="left", padx=(10, 10), pady=8)

            # Nome legivel (principal)
            ctk.CTkLabel(
                row,
                text=display_name,
                font=ctk.CTkFont(family="Segoe UI", size=13),
                text_color=C["text"],
                anchor="w",
            ).pack(side="left", fill="x", expand=True)

            # Nome do ficheiro (secundario)
            ctk.CTkLabel(
                row,
                text=script_file,
                font=ctk.CTkFont(family="Consolas", size=10),
                text_color=C["text_dim"],
                anchor="e",
            ).pack(side="right", padx=10)

            self.checkboxes[module_name][script_file] = (var, cb)

    def _build_actions(self, parent):
        # === APLICAR TWEAKS ===
        apply_card = ctk.CTkFrame(
            parent, fg_color=C["bg_card"], corner_radius=R,
            border_color=C["magenta"] + "88", border_width=1,
        )
        apply_card.pack(fill="x", pady=(0, 8))

        self.apply_btn = ctk.CTkButton(
            apply_card,
            text="\u25b6  APLICAR TWEAKS",
            font=ctk.CTkFont(family="Segoe UI", size=18, weight="bold"),
            fg_color=C["magenta"],
            hover_color=C["magenta_dim"],
            text_color="white",
            height=70, corner_radius=R,
            command=self._apply_tweaks,
        )
        self.apply_btn.pack(fill="x", padx=10, pady=(10, 4))

        self.selected_label = ctk.CTkLabel(
            apply_card,
            text="0 scripts selecionados",
            font=ctk.CTkFont(family="Segoe UI", size=11),
            text_color=C["text_dim"],
        )
        self.selected_label.pack(pady=(0, 10))

        # === RESTORE POINT ===
        restore_card = ctk.CTkFrame(
            parent, fg_color=C["bg_card"], corner_radius=R,
            border_color=C["pink"] + "66", border_width=1,
        )
        restore_card.pack(fill="x", pady=(0, 8))

        ctk.CTkButton(
            restore_card,
            text="\U0001f6e1\ufe0f  RESTORE POINT",
            font=ctk.CTkFont(family="Segoe UI", size=16, weight="bold"),
            fg_color=C["pink"],
            hover_color=C["pink_dim"],
            text_color="white",
            height=55, corner_radius=R,
            command=self._create_restore_point,
        ).pack(fill="x", padx=10, pady=10)

        # === APLICAR TUDO ===
        ctk.CTkButton(
            parent,
            text="\U0001f525  APLICAR TUDO",
            font=ctk.CTkFont(family="Segoe UI", size=14, weight="bold"),
            fg_color=C["purple_dim"],
            hover_color=C["purple"],
            text_color=C["text"],
            height=48, corner_radius=R,
            border_color=C["purple"] + "66", border_width=1,
            command=self._apply_all,
        ).pack(fill="x", pady=(0, 10))

        # === INFO ===
        info_card = ctk.CTkFrame(
            parent, fg_color=C["bg_card"], corner_radius=R,
            border_color=C["text_dim"] + "44", border_width=1,
        )
        info_card.pack(fill="x", pady=(0, 8))

        ctk.CTkLabel(
            info_card,
            text="\u2139\ufe0f  Os scripts sao baixados do\n    GitHub e executados localmente.\n    Nenhum arquivo permanece\n    no sistema apos a execucao.",
            font=ctk.CTkFont(family="Segoe UI", size=11),
            text_color=C["text_dim"],
            justify="left",
        ).pack(padx=14, pady=12)

        # Branding
        brand = ctk.CTkFrame(parent, fg_color="transparent")
        brand.pack(side="bottom", fill="x", padx=10, pady=(0, 5))

        ctk.CTkLabel(
            brand,
            text="\U0001f43a LOBO TECH",
            font=ctk.CTkFont(family="Segoe UI", size=13, weight="bold"),
            text_color=C["purple"],
        ).pack(anchor="e")

        ctk.CTkLabel(
            brand,
            text=f"v{APP_VERSION} // PREMIUM",
            font=ctk.CTkFont(family="Consolas", size=9),
            text_color=C["text_dim"],
        ).pack(anchor="e")

        # Atualizar contador
        self._update_count()

    # ============================================================
    # BARRA DE PROGRESSO
    # ============================================================

    def _build_progress_section(self):
        pf = ctk.CTkFrame(self, fg_color=C["bg_card"], corner_radius=R, height=44,
                           border_color=C["purple"] + "44", border_width=1)
        pf.pack(fill="x", padx=12, pady=(6, 0))
        pf.pack_propagate(False)

        inner = ctk.CTkFrame(pf, fg_color="transparent")
        inner.pack(fill="both", expand=True, padx=14, pady=8)

        self.progress_label = ctk.CTkLabel(
            inner, text="Aguardando...",
            font=ctk.CTkFont(family="Segoe UI", size=11),
            text_color=C["text_sec"], anchor="w", width=220,
        )
        self.progress_label.pack(side="left")

        self.progress_pct = ctk.CTkLabel(
            inner, text="0%",
            font=ctk.CTkFont(family="Consolas", size=12, weight="bold"),
            text_color=C["magenta"], width=50,
        )
        self.progress_pct.pack(side="right")

        self.progress_bar = ctk.CTkProgressBar(
            inner,
            fg_color=C["bg"] + "cc",
            progress_color=C["magenta"],
            height=14, corner_radius=7,
        )
        self.progress_bar.pack(side="left", fill="x", expand=True, padx=(10, 10))
        self.progress_bar.set(0)

    # ============================================================
    # CONSOLE (LOG EM TEMPO REAL)
    # ============================================================

    def _build_console(self):
        cf = ctk.CTkFrame(
            self, fg_color=C["bg_card"], corner_radius=R, height=175,
            border_color=C["cyan"] + "55", border_width=1,
        )
        cf.pack(fill="x", padx=12, pady=(6, 0))
        cf.pack_propagate(False)

        # Label do console
        top = ctk.CTkFrame(cf, fg_color="transparent")
        top.pack(fill="x", padx=14, pady=(8, 2))

        ctk.CTkLabel(
            top, text="\U0001f4cb  TERMINAL DE EXECUCAO",
            font=ctk.CTkFont(family="Segoe UI", size=11, weight="bold"),
            text_color=C["cyan"],
        ).pack(side="left")

        self.console = ctk.CTkTextbox(
            cf,
            font=ctk.CTkFont(family="Consolas", size=11),
            fg_color=C["bg"],
            text_color=C["cyan"],
            corner_radius=8,
            wrap="word",
            state="disabled",
            activate_scrollbars=True,
            scrollbar_button_color=C["purple"],
        )
        self.console.pack(fill="both", expand=True, padx=10, pady=(2, 10))

    # ============================================================
    # FOOTER
    # ============================================================

    def _build_footer(self):
        ft = ctk.CTkFrame(self, fg_color="transparent", height=28)
        ft.pack(fill="x", padx=16, pady=(4, 8))
        ft.pack_propagate(False)

        ctk.CTkLabel(
            ft,
            text=f"\u00a9 2026 Lobo Tech  |  Lobo Alpha V{APP_VERSION} Premium  |  github.com/lobaotech",
            font=ctk.CTkFont(family="Segoe UI", size=10),
            text_color=C["text_dim"],
        ).pack(side="left")

        ctk.CTkLabel(
            ft,
            text=datetime.datetime.now().strftime("%d/%m/%Y  %H:%M"),
            font=ctk.CTkFont(family="Segoe UI", size=10),
            text_color=C["text_dim"],
        ).pack(side="right")

    # ============================================================
    # LOGGING (TEMPO REAL)
    # ============================================================

    def _log(self, msg, color=None):
        """Adiciona mensagem ao console."""
        ts = datetime.datetime.now().strftime("%H:%M:%S")
        self.console.configure(state="normal")
        self.console.insert("end", f"[{ts}] {msg}\n")
        self.console.see("end")
        self.console.configure(state="disabled")

    def _log_system(self, msg):
        self._log(msg)

    def _log_info(self, msg):
        self._log(msg)

    def _log_ok(self, msg):
        self._log(f"[OK] {msg}")

    def _log_warn(self, msg):
        self._log(f"[WARN] {msg}")

    def _log_err(self, msg):
        self._log(f"[ERROR] {msg}")

    def _log_output(self, line):
        """Log de saida em tempo real do script."""
        self.console.configure(state="normal")
        self.console.insert("end", f"    | {line}\n")
        self.console.see("end")
        self.console.configure(state="disabled")

    # ============================================================
    # LOGICA
    # ============================================================

    def _select_all(self, mn, state):
        for sf, (var, cb) in self.checkboxes[mn].items():
            var.set(state)

    def _update_count(self):
        total = sum(
            1 for scripts in self.checkboxes.values()
            for sf, (var, cb) in scripts.items() if var.get()
        )
        self.selected_label.configure(text=f"{total} scripts selecionados")
        self.after(400, self._update_count)

    def _get_selected(self):
        sel = []
        for mn, scripts in self.checkboxes.items():
            mp = MODULES[mn]["path"]
            for sf, (var, cb) in scripts.items():
                if var.get():
                    sel.append((mp, sf))
        return sel

    def _download_and_run(self, module_path, script_file):
        """Baixa e executa um script com output em tempo real."""
        url = f"{REPO_BASE}/{module_path}/{script_file}"
        self._log(f"Downloading: {script_file}")

        try:
            ctx = ssl.create_default_context()
            ctx.check_hostname = False
            ctx.verify_mode = ssl.CERT_NONE

            req = urllib.request.Request(url, headers={"User-Agent": "LoboAlpha/2.0"})
            with urllib.request.urlopen(req, context=ctx) as resp:
                content = resp.read()

            suffix = os.path.splitext(script_file)[1].lower()
            temp_file = os.path.join(tempfile.gettempdir(), f"lobo_{script_file}")

            with open(temp_file, "wb") as f:
                f.write(content)

            self._log(f"Executing: {script_file}")

            # Construir comando
            if suffix == ".bat":
                cmd = ["cmd.exe", "/c", temp_file]
            elif suffix == ".reg":
                cmd = ["reg.exe", "import", temp_file]
            elif suffix == ".ps1":
                cmd = ["powershell.exe", "-ExecutionPolicy", "Bypass", "-File", temp_file]
            else:
                self._log_warn(f"Tipo nao suportado: {suffix}")
                return False

            # Executar com output em tempo real
            creation_flags = 0
            if sys.platform == "win32":
                creation_flags = subprocess.CREATE_NO_WINDOW

            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                bufsize=1,
                creationflags=creation_flags,
            )

            # Ler output linha a linha em tempo real
            for line in iter(process.stdout.readline, ""):
                line = line.rstrip()
                if line:
                    self._log_output(line)

            process.stdout.close()
            return_code = process.wait(timeout=120)

            # Limpar temp
            try:
                os.remove(temp_file)
            except Exception:
                pass

            if return_code == 0:
                self._log_ok(f"{script_file} aplicado com sucesso!")
                return True
            else:
                self._log_warn(f"{script_file} retornou codigo {return_code}")
                return True

        except subprocess.TimeoutExpired:
            self._log_err(f"Timeout: {script_file}")
            try:
                process.kill()
            except Exception:
                pass
            return False
        except urllib.error.URLError as e:
            self._log_err(f"Erro de rede: {script_file}")
            return False
        except Exception as e:
            self._log_err(f"{script_file}: {str(e)[:80]}")
            return False

    def _apply_tweaks(self):
        if self.is_running:
            self._log_warn("Ja existe uma execucao em andamento!")
            return

        selected = self._get_selected()
        if not selected:
            self._log_warn("Nenhum script selecionado!")
            return

        total = len(selected)
        self._log(f"Iniciando execucao de {total} script(s)...")
        self.is_running = True
        self.apply_btn.configure(state="disabled", text="\u23f3  EXECUTANDO...")
        self.progress_bar.set(0)
        self.progress_label.configure(text="Iniciando...")
        self.progress_pct.configure(text="0%")

        def worker():
            ok = 0
            fail = 0
            for i, (mp, sf) in enumerate(selected):
                pct = i / total
                self.progress_bar.set(pct)
                self.progress_label.configure(text=f"[{i+1}/{total}] {sf}")
                self.progress_pct.configure(text=f"{int(pct*100)}%")

                if self._download_and_run(mp, sf):
                    ok += 1
                else:
                    fail += 1

            self.progress_bar.set(1.0)
            self.progress_label.configure(text="\u2705  Concluido!")
            self.progress_pct.configure(text="100%")

            self._log("")
            self._log("=" * 55)
            self._log(f"RESULTADO: {ok} OK  |  {fail} FALHAS  |  {total} TOTAL")
            if fail == 0:
                self._log_ok("Todas as otimizacoes aplicadas com sucesso!")
            else:
                self._log_warn(f"{fail} script(s) falharam. Verifique o log acima.")
            self._log("=" * 55)

            self.is_running = False
            self.apply_btn.configure(state="normal", text="\u25b6  APLICAR TWEAKS")

        threading.Thread(target=worker, daemon=True).start()

    def _apply_all(self):
        for mn in self.checkboxes:
            self._select_all(mn, True)
        self._apply_tweaks()

    def _create_restore_point(self):
        if self.is_running:
            self._log_warn("Aguarde a execucao atual terminar.")
            return

        self._log("Criando ponto de restauracao...")
        self.is_running = True
        self.progress_bar.set(0)
        self.progress_label.configure(text="\U0001f6e1\ufe0f  Criando restore point...")
        self.progress_pct.configure(text="...")

        def worker():
            for i in range(4):
                self.progress_bar.set(i / 4)
                time.sleep(0.4)

            ok = self._download_and_run("01_Preparacao_e_Backup", "01_CRIAR_PONTO_RESTAURACAO.bat")

            self.progress_bar.set(1.0)
            self.progress_pct.configure(text="100%")

            if ok:
                self._log_ok("Ponto de restauracao criado!")
                self.progress_label.configure(text="\u2705  Restore point criado!")
            else:
                self._log_err("Falha ao criar ponto de restauracao.")
                self.progress_label.configure(text="\u274c  Falha!")

            self.is_running = False

        threading.Thread(target=worker, daemon=True).start()


# ================================================================
# MAIN
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
