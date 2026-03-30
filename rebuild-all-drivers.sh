#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Uso:
  ./rebuild-all-drivers.sh [--kernel KVER] [--out DIR] [--keep-workdir]

Opciones:
  --kernel KVER    Kernel destino a recompilar
  --out DIR        Directorio de salida. Default: out/KVER
  --keep-workdir   Conserva el directorio temporal de compilacion
  -h, --help       Muestra esta ayuda
EOF
}

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KVER="$(uname -r)"
KEEP_WORKDIR=0
OUT_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --kernel|-k)
      [[ $# -ge 2 ]] || fail "--kernel requiere un valor"
      KVER="$2"
      shift 2
      ;;
    --out|-o)
      [[ $# -ge 2 ]] || fail "--out requiere un directorio"
      OUT_DIR="$2"
      shift 2
      ;;
    --keep-workdir)
      KEEP_WORKDIR=1
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

KDIR="/lib/modules/$KVER/build"
[[ -d "$KDIR" ]] || fail "no existen headers para $KVER en $KDIR"

if [[ -z "$OUT_DIR" ]]; then
  OUT_DIR="$SCRIPT_DIR/out/$KVER"
fi
mkdir -p "$OUT_DIR"

WORKDIR="$(mktemp -d "${TMPDIR:-/tmp}/macbookpro-drivers-$KVER-XXXXXX")"
cleanup() {
  if [[ "$KEEP_WORKDIR" -eq 0 ]]; then
    rm -rf "$WORKDIR"
  fi
}
trap cleanup EXIT

extract_to() {
  local archive="$1"
  local target="$2"
  mkdir -p "$target"
  tar -xzf "$archive" -C "$target"
}

echo "Compilando para kernel: $KVER"
echo "Usando headers en: $KDIR"
echo "Directorio temporal: $WORKDIR"
echo "Salida: $OUT_DIR"
echo

extract_to "$SCRIPT_DIR/sources/facetimehd.tar.gz" "$WORKDIR/facetimehd"
extract_to "$SCRIPT_DIR/sources/snd-hda-codec-cs8409.tar.gz" "$WORKDIR/snd-hda-codec-cs8409"
extract_to "$SCRIPT_DIR/sources/hci_uart-patched-source.tar.gz" "$WORKDIR/hci_uart-patched-source"

make -C "$WORKDIR/facetimehd" KVERSION="$KVER"
install -m0644 "$WORKDIR/facetimehd/facetimehd.ko" "$OUT_DIR/facetimehd.ko"

make -C "$WORKDIR/snd-hda-codec-cs8409" KVER="$KVER"
install -m0644 "$WORKDIR/snd-hda-codec-cs8409/snd-hda-codec-cs8409.ko" \
  "$OUT_DIR/snd-hda-codec-cs8409.ko"

make -C "$KDIR" M="$WORKDIR/hci_uart-patched-source" modules
install -m0644 "$WORKDIR/hci_uart-patched-source/hci_uart.ko" "$OUT_DIR/hci_uart.ko"

sha256sum \
  "$OUT_DIR/facetimehd.ko" \
  "$OUT_DIR/snd-hda-codec-cs8409.ko" \
  "$OUT_DIR/hci_uart.ko" \
  > "$OUT_DIR/CHECKSUMS.sha256"

echo
echo "Compilacion terminada."
echo "Archivos generados:"
echo "  $OUT_DIR/facetimehd.ko"
echo "  $OUT_DIR/snd-hda-codec-cs8409.ko"
echo "  $OUT_DIR/hci_uart.ko"
echo "  $OUT_DIR/CHECKSUMS.sha256"
echo
echo "Para instalar los modulos compilados:"
echo "  sudo ./install-all-drivers.sh --kernel $KVER --from $OUT_DIR"
