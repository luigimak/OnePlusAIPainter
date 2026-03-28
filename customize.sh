#!/system/bin/sh

TARGET_FILE="/my_product/etc/extension/com.oplus.app-features.xml"
MOD_TARGET_DIR="$MODPATH/my_product/etc/extension"
MOD_TARGET_FILE="$MOD_TARGET_DIR/com.oplus.app-features.xml"
CLEANUP_SCRIPT="/data/adb/service.d/aipaint_cleanup.sh"

ui_print "- Start installation"

# --- Patch XML ---
if [ -f "$TARGET_FILE" ]; then
    ui_print "- Original file found. Patching..."
    mkdir -p "$MOD_TARGET_DIR"
    cp "$TARGET_FILE" "$MOD_TARGET_FILE"

    if grep -q "com.oplus.aipaint.function_switch" "$MOD_TARGET_FILE"; then
        ui_print "- Note: XML flag already set."
    else
        ui_print "- AI Painter flag insertion..."
        sed -i 's|<\/extend_features>|\t<app_feature name="com.oplus.aipaint.function_switch" args="boolean:true"/>\n<\/extend_features>|' "$MOD_TARGET_FILE"
    fi
else
    ui_print "! CRITICAL ERROR: $TARGET_FILE not found."
    abort "! Device not compatible. Installation canceled."
fi

# --- APK ---
ui_print "- APK configuration in the module..."
if [ -f "$MODPATH/AIPaint.apk" ]; then
    set_perm "$MODPATH/AIPaint.apk" 0 0 0644
else
    ui_print "! Notice: APK missing from module ZIP."
fi

# --- Cleanup script persistente in service.d ---
ui_print "- Installing cleanup watcher..."
mkdir -p /data/adb/service.d
cat > "$CLEANUP_SCRIPT" << 'EOF'
#!/system/bin/sh
MODPATH="/data/adb/modules/OnePlusAIPainter"
PKG="com.oplus.aipaint"

until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
done
sleep 5

if [ ! -d "$MODPATH" ]; then
    pm uninstall "$PKG"
    rm -f "$0"
    exit 0
fi
EOF
chmod 755 "$CLEANUP_SCRIPT"

# --- End ---
ui_print "- Finalizing permissions..."
set_perm_recursive "$MODPATH" 0 0 0755 0644
ui_print "- Operation completed!"
