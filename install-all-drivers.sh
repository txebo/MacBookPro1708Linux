#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Uso:
  sudo ./install-all-drivers.sh [--kernel KVER] [--from DIR] [--no-reload]

Opciones:
  --kernel KVER   Instala en /lib/modules/KVER/updates
  --from DIR      Toma los modulos desde otro directorio, por ejemplo out/KVER
  --no-reload     No intenta recargar Bluetooth en el kernel actual
  -h, --help      Muestra esta ayuda
EOF
}

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KVER="$(uname -r)"
MODULES_DIR="$SCRIPT_DIR/artifacts/modules"
RELOAD_CURRENT=1

while [[ $# -gt 0 ]]; do
  case "$1" in
    --kernel|-k)
      [[ $# -ge 2 ]] || fail "--kernel requiere un valor"
      KVER="$2"
      shift 2
      ;;
    --from|-f)
      [[ $# -ge 2 ]] || fail "--from requiere un directorio"
      MODULES_DIR="$2"
      shift 2
      ;;
    --no-reload)
      RELOAD_CURRENT=0
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      fail "opcion no reconocida: $1"
      ;;
  esac
done

[[ $EUID -eq 0 ]] || fail "ejecuta este script con sudo"
[[ -d "$MODULES_DIR" ]] || fail "no existe el directorio de modulos: $MODULES_DIR"

for module_file in facetimehd.ko snd-hda-codec-cs8409.ko hci_uart.ko; do
  [[ -f "$MODULES_DIR/$module_file" ]] || fail "falta $MODULES_DIR/$module_file"
done

FIRMWARE_ROOT="/usr/lib/firmware"
if [[ ! -d "$FIRMWARE_ROOT" && ! -L "$FIRMWARE_ROOT" ]]; then
  FIRMWARE_ROOT="/lib/firmware"
fi

install -Dm0644 "$MODULES_DIR/facetimehd.ko" "/lib/modules/$KVER/updates/facetimehd.ko"
install -Dm0644 "$MODULES_DIR/snd-hda-codec-cs8409.ko" "/lib/modules/$KVER/updates/snd-hda-codec-cs8409.ko"
install -Dm0644 "$MODULES_DIR/hci_uart.ko" "/lib/modules/$KVER/updates/hci_uart.ko"

install -Dm0644 "$SCRIPT_DIR/artifacts/firmware/facetimehd/firmware.bin" \
  "$FIRMWARE_ROOT/facetimehd/firmware.bin"
install -Dm0644 "$SCRIPT_DIR/artifacts/firmware/brcm/BCM-0a5c-6410.hcd.zst" \
  "$FIRMWARE_ROOT/brcm/BCM-0a5c-6410.hcd.zst"
ln -sfn BCM-0a5c-6410.hcd.zst "$FIRMWARE_ROOT/brcm/BCM.hcd.zst"

depmod -a "$KVER"

CURRENT_KERNEL="$(uname -r)"
if [[ "$KVER" == "$CURRENT_KERNEL" && "$RELOAD_CURRENT" -eq 1 ]]; then
  systemctl stop bluetooth 2>/dev/null || true
  modprobe -r hci_uart 2>/dev/null || true
  modprobe hci_uart 2>/dev/null || true
  systemctl start bluetooth 2>/dev/null || true
  modprobe facetimehd 2>/dev/null || true
  modprobe snd_hda_codec_cs8409 2>/dev/null || true
fi

echo
echo "Instalacion terminada para kernel: $KVER"
echo "Modulos copiados desde: $MODULES_DIR"
echo "Firmware root: $FIRMWARE_ROOT"
echo
echo "Verificacion sugerida:"
echo "  modinfo -n facetimehd snd-hda-codec-cs8409 hci_uart"
echo "  bluetoothctl show"
echo "  hciconfig -a"
echo
echo "Para audio y camara, se recomienda reiniciar despues de instalar."
