if $BOOTMODE; then
    ui_print "- Installing from Magisk app"
else
    ui_print "*********************************************************"
    ui_print "! Install from recovery is NOT supported"
    ui_print "! Please install from Magisk app"
    abort    "*********************************************************"
fi

CODENAME=$(getprop ro.product.vendor.device)
BUILDID=$(getprop ro.vendor.build.id)
MODEMVER=$(getprop gsm.version.baseband)
CFGVER=$(cat /vendor/firmware/carrierconfig/release-label)
CFGHASH=$(toybox sha256sum -b /vendor/firmware/carrierconfig/cfg.db)

ui_print "- Magisk version is: $MAGISK_VER_CODE"
ui_print "- Device is: $CODENAME"
ui_print "- Build ID is: $BUILDID"
ui_print "- Modem version is: $MODEMVER"
ui_print "- CFG version is: $CFGVER"
ui_print "- CFG file state is: $CFGHASH"
ui_print "- Note, that this module is only for SoC Google Tensor devices!"


# In this module we try to fix LTE restrictions on non-certified
# (actually CIS) networks for Google Tensor devices by force set
# "it_iliad (2124)" config as the best discovered solution for this networks to the default
# WILDCARD (0), PTCRB (20001) and  PTCRB_ROW (20005) configs under this pattern:
# confnames -> it_iliad -> 2124 -> confmap -> 2124_as_hash -> WILDCARD (0) / PTCRB (20001) / PTCRB_ROW (20005) -> it_iliad_2124_hash
# CA table from "it_iliad (2124)" config can be found here: https://cacombos.com/device/GVU6C?combolist=iliad_italy
# !!!!!!!!!! CA combinations currently not implemented !!!!!!!!!!


    # Pixel 7/7P/7a product line (panther, cheetah, lynx)
if [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] || [ "$CODENAME" == "lynx" ] && [ "$CFGVER" == "cfgdb-whipro_r16-230818-B-10680050" ]; then
    cp -rf "$MODPATH/cfgs/pixel_7/cfgdb-whipro_r16-230818-B-10680050/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] || [ "$CODENAME" == "lynx" ] && [ "$CFGVER" == "cfgdb-whipro-230427-B-10022403" ]; then
    cp -rf "$MODPATH/cfgs/pixel_7/cfgdb-whipro-230427-B-10022403/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] || [ "$CODENAME" == "lynx" ] && [ "$CFGVER" == "cfgdb-whipro-230323-B-9800995" ]; then
    cp -rf "$MODPATH/cfgs/pixel_7/cfgdb-whipro-230323-B-9800995/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] || [ "$CODENAME" == "lynx" ] && [ "$CFGVER" == "cfgdb-whipro-230210-B-9589366" ]; then
    cp -rf "$MODPATH/cfgs/pixel_7/cfgdb-whipro-230210-B-9589366/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] || [ "$CODENAME" == "lynx" ] && [ "$CFGVER" == "cfgdb-whipro-221028-B-9229469" ]; then
    cp -rf "$MODPATH/cfgs/pixel_7/cfgdb-whipro-221028-B-9229469/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

    # Pixel 6/6P/6a product line (oriole, raven, bluejay)
elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVER" == "cfgdb-whi-230818-B-10678034" ]; then
    cp -rf "$MODPATH/cfgs/pixel_6/cfgdb-whi-230818-B-10678034/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVER" == "cfgdb-whi-230428-B-10034304" ]; then
    cp -rf "$MODPATH/cfgs/pixel_6/cfgdb-whi-230428-B-10034304/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVER" == "cfgdb-whi-230323-B-9800744" ]; then
    cp -rf "$MODPATH/cfgs/pixel_6/cfgdb-whi-230323-B-9800744/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVER" == "cfgdb-whi-230302-B-9675756" ]; then
    cp -rf "$MODPATH/cfgs/pixel_6/cfgdb-whi-230302-B-9675756/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVER" == "cfgdb-whi-221101-B-9242015" ]; then
    cp -rf "$MODPATH/cfgs/pixel_6/cfgdb-whi-221101-B-9242015/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVER" == "cfgdb-whi-220830-B-9008086" ]; then
    cp -rf "$MODPATH/cfgs/pixel_6/cfgdb-whi-220830-B-9008086/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVER" == "cfgdb-whi-220727-B-8875237" ]; then
    cp -rf "$MODPATH/cfgs/pixel_6/cfgdb-whi-220727-B-8875237/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

else
    abort "- Your device, config file or ROM build unsupported yet!"
fi

# Sets SELinux context manually to avoid breaking on Magisk 26xxx+
chcon u:object_r:vendor_fw_file:s0 "$MODPATH/system/vendor/firmware/carrierconfig/cfg.db"

rm -rf $MODPATH/cfgs/
