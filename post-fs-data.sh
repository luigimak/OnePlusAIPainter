#!/system/bin/sh
MODDIR=${0%/*}

# XML patch
MOD_XML="$MODDIR/my_product/etc/extension/com.oplus.app-features.xml"
SYS_XML="/my_product/etc/extension/com.oplus.app-features.xml"

if [ -f "$MOD_XML" ]; then
    mount --bind "$MOD_XML" "$SYS_XML"
fi
