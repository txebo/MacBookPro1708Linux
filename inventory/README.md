# Inventario de apps y configuracion

Exportado el `2026-03-30` desde esta maquina.

## Resumen

- paquetes instalados por `dpkg`: `2613`
- paquetes marcados como manuales: `1993`
- apps Flatpak: `8`
- apps Snap: `0`
- extensiones de VS Code: `17`
- skills detectadas en Codex: `7`
- plugins detectados en Codex: `3`

## Archivos incluidos

### Apps y paquetes

- `apps/apt-installed.tsv`
- `apps/apt-manual.txt`
- `apps/flatpak-apps.tsv`
- `apps/snap-apps.txt`
- `apps/vscode-version.txt`
- `apps/vscode-extensions.txt`
- `apps/codex-version.txt`
- `apps/codex-skills.txt`
- `apps/codex-plugins.txt`

### Configuracion exportada

- `config/vscode/settings.json`
- `config/vscode/mcp.json`
- `config/vscode/chatLanguageModels.json`
- `config/codex/config.toml`
- `config/codex/default.rules`

## Omisiones intencionales

No se subieron archivos con credenciales, sesiones o estado sensible. En particular se dejaron fuera:

- `~/.codex/auth.json`
- `~/.codex/sessions/`
- `~/.codex/logs_*.sqlite`
- `~/.codex/cache/`
- `~/.config/Code/User/globalStorage/`
- `~/.config/Code/User/workspaceStorage/`
- `~/.config/Code/User/History/`

## Notas

- `mcp.json` de VS Code esta presente pero vacio en esta exportacion.
- No habia snippets de usuario en `~/.config/Code/User/snippets/` al momento del respaldo.
- `default.rules` de Codex incluye reglas locales de permisos y rutas usadas en esta maquina.
