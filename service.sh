#!/system/bin/sh
MODDIR=${0%/*}
APK="$MODDIR/AIPaint.apk"
APP_PACKAGE="com.oplus.aipaint"
MOD_APK_VERSION="16.0.20"

until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
done
sleep 5

if [ ! -f "$APK" ]; then
    exit 0
fi

version_gt() {
    echo "$1 $2" | awk '{
        n = split($1, a, ".");
        split($2, b, ".");
        for (i = 1; i <= 3; i++) {
            ai = a[i] + 0;
            bi = b[i] + 0;
            if (ai > bi) { print "gt"; exit }
            if (ai < bi) { print "lt"; exit }
        }
        print "eq"
    }'
}

INSTALLED_VERSION=$(pm dump $APP_PACKAGE | grep versionName | head -n 1 | cut -d'=' -f2 | tr -d '[:space:]')

if [ -z "$INSTALLED_VERSION" ]; then
    pm install -r --install-reason 1 "$APK"
else
    CMP=$(version_gt "$MOD_APK_VERSION" "$INSTALLED_VERSION")
    if [ "$CMP" = "gt" ]; then
        pm install -r --install-reason 1 "$APK"
    fi
fi
