# OnePlus AI Painter Enabler

This module enables the **AI Painter** feature on OnePlus devices running **OxygenOS 16**. It performs a dynamic XML patch to the system features and installs the necessary system application via `pm install`.

## Features
* **Dynamic Patching**: Extracts `com.oplus.app-features.xml` directly from your device during installation to ensure 100% compatibility with your current firmware.
* **APK Installation**: Installs AIPaint 16.0.20 at first boot via `pm install`, only if the system version is outdated.
* **Clean Uninstall**: A persistent watcher in `service.d` detects module removal and automatically reverts to the stock APK version on next boot.

## Requirements
* OnePlus device running **OxygenOS 16**.
* Magisk 24.0+ or KernelSU/APatch.

## Installation
1. Download the latest `OnePlusAIPainter-vX.X.X.zip` from the [Releases](#) section.
2. Open Magisk/KernelSU app.
3. Select "Install from storage" and choose the downloaded ZIP.
4. Reboot your device.

## Uninstallation
Disable or remove the module from your Magisk/KernelSU manager and reboot. The cleanup watcher will automatically revert to the stock APK version on next boot.

## Module Structure
```
OnePlusAIPainter/
├── AIPaint.apk
├── customize.sh
├── post-fs-data.sh
├── service.sh
├── module.prop
└── LICENSE
```

## Disclaimer & License
* **Scripts**: The shell scripts and module configuration are licensed under the **GNU GPL v3**.
* **Proprietary Content**: The `AIPaint.apk` file is the property of **OnePlus/Oppo**. It is provided here for interoperability purposes only.
* **Responsibility**: I am not responsible for any damage to your device. Use at your own risk.

---
**Author**: luigimak
