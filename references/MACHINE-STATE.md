# Estado de la maquina

Bundle generado el `2026-03-30`.

## Equipo validado

- modelo: `MacBookPro13,1`
- sistema: `Linux Mint 22.3`
- kernel: `6.8.0-106-generic`

## Modulos activos validados

- `/lib/modules/6.8.0-106-generic/updates/facetimehd.ko`
- `/lib/modules/6.8.0-106-generic/updates/snd-hda-codec-cs8409.ko`
- `/lib/modules/6.8.0-106-generic/updates/hci_uart.ko`

## Firmware validado

- `/lib/firmware/facetimehd/firmware.bin`
- `/usr/lib/firmware/brcm/BCM-0a5c-6410.hcd.zst`
- alias usado para Bluetooth:
  `/usr/lib/firmware/brcm/BCM.hcd.zst -> BCM-0a5c-6410.hcd.zst`

## Verificacion hecha

- `bluetoothctl show` con `Powered: yes`
- `hciconfig -a` con `UP RUNNING`
- `modinfo -n facetimehd snd-hda-codec-cs8409 hci_uart` apuntando a `updates/`
- `rebuild-all-drivers.sh --kernel 6.8.0-106-generic` recompilo los tres modulos del bundle con exito

## Checksums de referencia

- `facetimehd.ko`
  `e6a39b5aab58f1754321225e46c1aa8d823b143cabbadf22a889b2c508961695`
- `snd-hda-codec-cs8409.ko`
  `8da07aaa43ae976ae39813ad70d6f377f1b080b861e2b5521c324267faf5c21f`
- `hci_uart.ko`
  `284c6f057d22e94d54f4d4aab3bfa94eeacdd93badf35a62ebb31fc6cfaa737e`
- `firmware.bin`
  `e3e6034a67dfdaa27672dd547698bbc5b33f47f1fc7f5572a2fb68ea09d32d3d`
- `BCM-0a5c-6410.hcd.zst`
  `5d9400a9bcbc179af93c67c328e11cf785d67d66155f87aa58c52efca39556a5`

Los checksums completos del bundle estan en `references/CHECKSUMS.sha256`.
