#!/system/bin/sh
# Do not hardcode /magisk/modname/...; use $MODDIR/...
# This will make your script more compatible, even if Magisk changes its mount point in the future.
MODDIR=${0%/*}
mount --bind $MODDIR/my_product/etc/extension/com.oplus.app-features.xml /my_product/etc/extension/com.oplus.app-features.xml
# This script will execute in post-fs-data mode (execute before system startup).