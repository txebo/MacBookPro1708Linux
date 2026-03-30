# Upstream y referencias

## Fuentes usadas para este bundle

### Camara FaceTime HD

- upstream: `https://github.com/patjak/facetimehd.git`
- commit usado: `a0669133438f4e507b2e4f45a49f3b7af5ebcfae`
- copia local usada: `/home/tx/workspace/drivers/facetimehd`
- snapshot incluido: `sources/facetimehd.tar.gz`

### Firmware FaceTime HD

- upstream: `https://github.com/patjak/facetimehd-firmware.git`
- commit usado: `1f2262e2a407e0d8bef929eedaa035aa878b6b89`
- copia local usada: `/home/tx/workspace/drivers/facetimehd-firmware`
- snapshot incluido: `sources/facetimehd-firmware.tar.gz`

### Audio CS8409

- upstream: `https://github.com/egorenar/snd-hda-codec-cs8409.git`
- commit usado: `d8c9001418e6172099a0907f022534f152e29d71`
- copia local usada: `/home/tx/workspace/drivers/snd-hda-codec-cs8409`
- snapshot incluido: `sources/snd-hda-codec-cs8409.tar.gz`

### Bluetooth Broadcom / hci_uart

- upstream base: `https://github.com/leifliddy/macbook12-bluetooth-driver.git`
- commit usado: `d393bf988644f0ce24f57c031febe0d9a4256f89`
- copia local usada: `/home/tx/workspace/drivers/macbook12-bluetooth-driver`
- snapshot upstream incluido: `sources/macbook12-bluetooth-driver.tar.gz`
- copia de trabajo exacta usada para el modulo funcional:
  `/home/tx/dev/MTC/.codex-bluetooth-fix`
- snapshot de esa copia de trabajo:
  `sources/bluetooth-fix-working-copy.tar.gz`
- snapshot parchado minimo para recompilar:
  `sources/hci_uart-patched-source.tar.gz`

## Referencias utiles

- estado Linux para MacBook Pro 2016-2017:
  `https://github.com/Dunedan/mbp-2016-linux`
- issue de Bluetooth para estos equipos:
  `https://github.com/Dunedan/mbp-2016-linux/issues/29`

## Nota importante

Para Bluetooth se guarda tanto el repo upstream como la copia de trabajo exacta que produjo el modulo funcional. El snapshot parchado es la base recomendada para recompilar sin depender de descargas o parches manuales.
