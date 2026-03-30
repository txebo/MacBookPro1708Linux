# MacBookPro13,1 Bluetooth Fix

Bluetooth fix bundle for `MacBookPro13,1` on:

- Linux Mint `22.3`
- Ubuntu 24.04 family
- kernel `6.8.0-106-generic`
- Broadcom `BCM4350`

## Included

- `hci_uart.ko`
- `install-built-hci_uart.sh`
- this `README.md`

## Install

```bash
git clone https://github.com/txebo/MacBookPro1708Linux.git
cd MacBookPro1708Linux
sudo ./install-built-hci_uart.sh
```

## Validation

- `bluetoothctl show` => `Powered: yes`
- `hciconfig -a` => `UP RUNNING`

## Notes

- validated on `MacBookPro13,1`
- validated with kernel `6.8.0-106-generic`
- module SHA-256:
  `284c6f057d22e94d54f4d4aab3bfa94eeacdd93badf35a62ebb31fc6cfaa737e`

## References

- `https://github.com/Dunedan/mbp-2016-linux/issues/29`
- `https://github.com/leifliddy/macbook12-bluetooth-driver`
