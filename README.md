# MacBookPro Linux Driver Bundle

Bundle reproducible de drivers, firmware y fuentes para esta maquina.

Validado en:

- modelo `MacBookPro13,1`
- Linux Mint `22.3`
- kernel `6.8.0-106-generic`

Incluye:

- modulos ya compilados que funcionan en esta maquina
- firmware necesario para camara y Bluetooth
- copias de las fuentes exactas usadas para compilar
- referencias a upstream, commits y checksums
- inventario de apps instaladas y configuracion exportada de VS Code y Codex
- un script para instalar todo
- un script para recompilar al cambiar de kernel o distro

## Estructura

- `artifacts/modules/`: `facetimehd.ko`, `snd-hda-codec-cs8409.ko`, `hci_uart.ko`
- `artifacts/firmware/`: firmware de camara y Bluetooth
- `sources/`: snapshots `.tar.gz` de todo el codigo fuente relevante
- `references/`: origenes, estado de la maquina y checksums
- `inventory/`: inventario de apps y configuracion exportada
- `install-all-drivers.sh`: instala modulos y firmware
- `rebuild-all-drivers.sh`: recompila para otro kernel

## Instalacion rapida

```bash
git clone https://github.com/txebo/MacBookPro1708Linux.git
cd MacBookPro1708Linux
sudo ./install-all-drivers.sh
```

Despues de instalar, conviene reiniciar para que audio y camara carguen limpio con el kernel actual.

## Recompilar para otro kernel

Primero instala headers y toolchain para el kernel destino.

En Debian, Ubuntu o Mint, normalmente basta con algo como:

```bash
sudo apt install build-essential linux-headers-$(uname -r)
```

Para un kernel distinto al actual:

```bash
./rebuild-all-drivers.sh --kernel 6.8.0-107-generic
sudo ./install-all-drivers.sh --kernel 6.8.0-107-generic --from out/6.8.0-107-generic
```

En otra distro cambia el paquete de headers y la toolchain por su equivalente, pero el flujo es el mismo.

## Fuentes incluidas

- `sources/facetimehd.tar.gz`
- `sources/facetimehd-firmware.tar.gz`
- `sources/snd-hda-codec-cs8409.tar.gz`
- `sources/macbook12-bluetooth-driver.tar.gz`
- `sources/bluetooth-fix-working-copy.tar.gz`
- `sources/hci_uart-patched-source.tar.gz`

`bluetooth-fix-working-copy.tar.gz` guarda la copia de trabajo exacta que produjo el `hci_uart.ko` funcional de esta maquina.

`hci_uart-patched-source.tar.gz` guarda solo el arbol de fuentes ya listo para recompilar `hci_uart` sin depender de descargas extra ni de parches manuales.

## Verificacion

Comandos utiles despues de instalar:

```bash
modinfo -n facetimehd snd-hda-codec-cs8409 hci_uart
bluetoothctl show
hciconfig -a
```

Lo esperado para Bluetooth es `Powered: yes` y `UP RUNNING`.

Los checksums del bundle estan en `references/CHECKSUMS.sha256`.

Para verificarlos desde la raiz del repo:

```bash
sha256sum -c references/CHECKSUMS.sha256
```

## Inventario y configuracion

Dentro de `inventory/` quedan:

- `apps/apt-installed.tsv`: todos los paquetes instalados por `dpkg`
- `apps/apt-manual.txt`: paquetes marcados como manuales
- `apps/flatpak-apps.tsv`: apps Flatpak instaladas
- `apps/snap-apps.txt`: inventario Snap
- `apps/vscode-version.txt`: version instalada de VS Code
- `apps/vscode-extensions.txt`: extensiones instaladas de VS Code
- `apps/codex-version.txt`: version instalada de Codex CLI
- `apps/codex-skills.txt`: skills visibles en Codex
- `apps/codex-plugins.txt`: plugins visibles en Codex
- `config/vscode/`: `settings.json`, `mcp.json` y `chatLanguageModels.json`
- `config/codex/`: `config.toml` y `default.rules`

No se incluyen secretos ni estado sensible como `auth.json`, sesiones, caches, logs o `globalStorage`.
