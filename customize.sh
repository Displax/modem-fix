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


# In this module we try to fix LTE restrictions on non-certified
# (actually CIS) networks for Google Tensor devices by force set
# "it_iliad (2124)" config as the best discovered solution for this networks to the default
# WILDCARD (0), PTCRB (20001) and  PTCRB_ROW (20005) configs under this pattern:
# confnames -> it_iliad -> 2124 -> confmap -> 2124_as_hash -> WILDCARD (0) / PTCRB (20001) / PTCRB_ROW (20005) -> it_iliad_2124_hash
# CA table from "it_iliad (2124)" config can be found here: https://cacombos.com/device/GVU6C?combolist=iliad_italy
# !!!!!!!!!! CA combinations currently not implemented !!!!!!!!!!


# Pixel 7 (Pro) product line matrix (panther, cheetah)
#
# Android      Build Number            Release Date      CFG Version                         CFG SHA-256 Hash                                                      it_iliad_2124_hash
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 13.0.0       TD1A.220804.009.A2      Oct 2022          cfgdb-whipro-220812-B-8938343       2284622a32b772fa07470dd1027cb3e7c6e1f1b2ad0b48e19487cc1a0912f54c      9b1917cf0f87bc8ab95df0594fdf667446d6d985
# 13.0.0       TD1A.220804.031         Oct 2022          cfgdb-whipro-220904-B-9027250       03ebb30965039c65f91e8720faf7f545200be0c9d530fa5181c58f93fef23176      3df4fd99b9a4e1910570d7a28d7f2d072f5c8277
# 13.0.0       TD1A.221105.001         Nov 2022          cfgdb-whipro-220904-B-9027250	     03ebb30965039c65f91e8720faf7f545200be0c9d530fa5181c58f93fef23176      3df4fd99b9a4e1910570d7a28d7f2d072f5c8277
# 13.0.0       TQ1A.221205.011         Dec 2022          cfgdb-whipro-221028-B-9229469       607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ1A.230105.002         Jan 2023          cfgdb-whipro-221028-B-9229469       607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ1A.230105.001.A2      Jan 2023          cfgdb-whipro-221028-B-9229469       607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ1A.230205.002         Feb 2023          cfgdb-whipro-221028-B-9229469       607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ2A.230305.008         Mar 2023          cfgdb-whipro-230210-B-9589366       543f166c290a2d503b853164f77cbd62e9b1c4d22d3423e0f44b51cc68c5e66c      363ea196cb28a63decea20ecf726a1fa4d25eb59
# 13.0.0       TQ2A.230305.008.C1      Mar 2023          cfgdb-whipro-230210-B-9589366       543f166c290a2d503b853164f77cbd62e9b1c4d22d3423e0f44b51cc68c5e66c      363ea196cb28a63decea20ecf726a1fa4d25eb59
# 13.0.0       TQ2A.230405.003.E1      Apr 2023          cfgdb-whipro-230323-B-9800995       d304b14f23bb37fecf9d8cc8695b2c2255e21404aafa35665d6235812ef57237      363ea196cb28a63decea20ecf726a1fa4d25eb59
# 13.0.0       TQ2A.230505.002         May 2023          cfgdb-whipro-230323-B-9800995       d304b14f23bb37fecf9d8cc8695b2c2255e21404aafa35665d6235812ef57237      363ea196cb28a63decea20ecf726a1fa4d25eb59
# 13.0.0       TQ3A.230605.012         Jun 2023          cfgdb-whipro-230427-B-10022403      495609840c141aea71c7c81c50a222811c5e4101bcd6e2fbaa75a963e7f61fc9      2b856cbb8c4923f0aee0b2891046bf2f6bfaa557


# Pixel 6a product line matrix (bluejay)
#
# Android      Build Number            Release Date      CFG Version                         CFG SHA-256 Hash                                                      it_iliad_2124_hash
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 12.1.0       SD2A.220601.003         Jun 2022          ?                                   ?                                                                     ?
# 12.1.0       SD2A.220601.003.B1      Jul 2022          ?                                   ?                                                                     ?
# 13.0.0       TP1A.220624.021.A1      Aug 2022          ?                                   ?                                                                     ?
# 13.0.0       TP1A.220905.004.A2      Sep 2022          cfgdb-whi-220727-B-8875237          6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TP1A.221005.003         Oct 2022          cfgdb-whi-220830-B-9008086          c4e0af33779023aad5fb0ad1f363e88d9457456728f173f484ae463a54bd5522      48784c95ab72d90e641311d4dc9b6e8e59bf3dc7
# 13.0.0       TP1A.221105.002         Nov 2022          cfgdb-whi-220830-B-9008086          c4e0af33779023aad5fb0ad1f363e88d9457456728f173f484ae463a54bd5522      48784c95ab72d90e641311d4dc9b6e8e59bf3dc7
# 13.0.0       TQ1A.221205.011         Dec 2022          cfgdb-whi-221101-B-9242015          1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.230105.001.A2      Jan 2023          cfgdb-whi-221101-B-9242015          1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.230205.002         Feb 2023          cfgdb-whi-221101-B-9242015          1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ2A.230305.008.E1      Mar 2023          cfgdb-whi-230302-B-9675756          772122dfaa7ae641a6386c375d06ea6d3e9c159fce3c57f35d9277199debc268      d09a227525324ae85e72e29b864e69a2de2fa448
# 13.0.0       TQ2A.230405.003.E1      Apr 2023          cfgdb-whi-230323-B-9800744          807a9cf915679cd08b799346537c7ea6277bb9b4e45f437e75b90363bc36b390      2ad9755505952d4253580d075076c2c2669dbe60
# 13.0.0       TQ2A.230505.002         May 2023          cfgdb-whi-230323-B-9800744          807a9cf915679cd08b799346537c7ea6277bb9b4e45f437e75b90363bc36b390      2ad9755505952d4253580d075076c2c2669dbe60
# 13.0.0       TQ3A.230605.010         Jun 2023          cfgdb-whi-230428-B-10034304         abd9876f2c0d27bab0478cf9f79a055b380d52a7f0fa82c348e59a919b4925e5      a282d508fe77e0f64a2374e569baed9b1e0f5fea


# Pixel 6 (Pro) product line matrix (oriole, raven)
#
# Android      Build Number            Release Date      CFG Version                         CFG SHA-256 Hash                                                      it_iliad_2124_hash
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 12.0.0       SD1A.210817.015.A4      Oct 2021          ?                                   ?                                                                     ?
# 12.0.0       SD1A.210817.036         Nov 2021          cfgdb-wc-211005-B-7794072           e23b3f2cc6cc72441f3b6af561127a9747148fb99d4826c9208a09e9ee34e687      57e38baf9cbaf50389cdcac9dc657cc7bf074ba9
# 12.0.0       SD1A.210817.037         Nov 2021          cfgdb-wc-211005-B-7794072           e23b3f2cc6cc72441f3b6af561127a9747148fb99d4826c9208a09e9ee34e687      57e38baf9cbaf50389cdcac9dc657cc7bf074ba9
# 12.0.0       SQ1D.220105.007         Jan 2022          cfgdb-wc-211223-B-8025189           810659bcda157c0b909ef344b423aaacca94fcea9f4f80d8ba6632339caaafb7      298dd4caed820e9be0d0009816c5fe83f5ceab28
# 12.0.0       SQ1D.220205.003         Feb 2022          cfgdb-wc-211223-B-8025189           810659bcda157c0b909ef344b423aaacca94fcea9f4f80d8ba6632339caaafb7      298dd4caed820e9be0d0009816c5fe83f5ceab28
# 12.0.0       SQ1D.220205.004         Feb 2022          cfgdb-whi-220211-B-8174161          dfacdfc652f2407b04a9772af126b49112a49980e46c775823921dd9d2a8c4d4      b7bcdffc7475e6d00dda1cff7bf57b82be03a40b
# 12.1.0       SP2A.220305.013.A3      Mar 2022          cfgdb-whi-220211-B-8174161          dfacdfc652f2407b04a9772af126b49112a49980e46c775823921dd9d2a8c4d4      b7bcdffc7475e6d00dda1cff7bf57b82be03a40b
# 12.1.0       SP2A.220405.004         Apr 2022          cfgdb-whi-220211-B-8174161          dfacdfc652f2407b04a9772af126b49112a49980e46c775823921dd9d2a8c4d4      b7bcdffc7475e6d00dda1cff7bf57b82be03a40b
# 12.1.0       SP2A.220505.002         May 2022          ?                                   ?                                                                     ?
# 12.1.0       SQ3A.220605.009.B1      Jun 2022          ?                                   ?                                                                     ?
# 12.1.0       SQ3A.220705.003         Jul 2022          ?                                   ?                                                                     ?
# 12.1.0       SQ3A.220705.004         Jul 2022          ?                                   ?                                                                     ?
# 13.0.0       TP1A.220624.021         Aug 2022          ?                                   ?                                                                     ?
# 13.0.0       TP1A.220905.004         Sep 2022          cfgdb-whi-220727-B-8875237          6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TP1A.221005.002         Oct 2022          cfgdb-whi-220727-B-8875237          6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TP1A.221105.002         Nov 2022          cfgdb-whi-220727-B-8875237          6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TQ1A.221205.011         Dec 2022          cfgdb-whi-221101-B-9242015          1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.230105.002         Jan 2023          cfgdb-whi-221101-B-9242015          1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.230205.002         Feb 2023          cfgdb-whi-221101-B-9242015          1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ2A.230305.008.E1      Mar 2023          cfgdb-whi-230302-B-9675756          772122dfaa7ae641a6386c375d06ea6d3e9c159fce3c57f35d9277199debc268      d09a227525324ae85e72e29b864e69a2de2fa448
# 13.0.0       TQ2A.230405.003.E1      Apr 2023          cfgdb-whi-230323-B-9800744          807a9cf915679cd08b799346537c7ea6277bb9b4e45f437e75b90363bc36b390      2ad9755505952d4253580d075076c2c2669dbe60
# 13.0.0       TQ2A.230505.002         May 2023          cfgdb-whi-230323-B-9800744          807a9cf915679cd08b799346537c7ea6277bb9b4e45f437e75b90363bc36b390      2ad9755505952d4253580d075076c2c2669dbe60
# 13.0.0       TQ3A.230605.010         Jun 2023          cfgdb-whi-230428-B-10034304         abd9876f2c0d27bab0478cf9f79a055b380d52a7f0fa82c348e59a919b4925e5      a282d508fe77e0f64a2374e569baed9b1e0f5fea


    # Pixel 7/7P product line (panther, cheetah)
if [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVER" == "cfgdb-whipro-230427-B-10022403" ]; then
    cp -rf "$MODPATH/cfgs/pixel_7/cfgdb-whipro-230427-B-10022403/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVER" == "cfgdb-whipro-230323-B-9800995" ]; then
    cp -rf "$MODPATH/cfgs/pixel_7/cfgdb-whipro-230323-B-9800995/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVER" == "cfgdb-whipro-230210-B-9589366" ]; then
    cp -rf "$MODPATH/cfgs/pixel_7/cfgdb-whipro-230210-B-9589366/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVER" == "cfgdb-whipro-221028-B-9229469" ]; then
    cp -rf "$MODPATH/cfgs/pixel_7/cfgdb-whipro-221028-B-9229469/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

    # Pixel 6/6P/6a product line (oriole, raven, bluejay)
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
    ui_print "- Note, that this module is only for SoC Google Tensor devices!"
    abort    "- Your device, config file or ROM build unsupported yet!"
fi

# Sets SELinux context manually to avoid breaking on Magisk 26xxx+
chcon u:object_r:vendor_fw_file:s0 "$MODPATH/system/vendor/firmware/carrierconfig/cfg.db"

rm -rf $MODPATH/cfgs/
