if $BOOTMODE; then
    ui_print "- Installing from Magisk app"
else
    ui_print "*********************************************************"
    ui_print "! Install from recovery is NOT supported"
    ui_print "! Please install from Magisk app"
    abort    "*********************************************************"
fi

ui_print "- Magisk version: $MAGISK_VER_CODE"

CODENAME=$(getprop ro.product.vendor.device)
CFGVERSION=$(cat /vendor/firmware/carrierconfig/release-label)
CFGHASH=$(toybox sha256sum -b /vendor/firmware/carrierconfig/cfg.db)


# In this module we try to fix LTE restrictions on non-certified
# (CIS) networks for Google Tensor devices by force set
# it_iliad (2124) config as the best discovered solution to the default
# WILDCARD (0), PTCRB (20001) and  PTCRB_ROW (20005) configs under this pattern:
# confnames -> it_iliad -> 2124 -> confmap -> 2124_as_hash -> WILDCARD (0) / PTCRB (20001) / PTCRB_ROW (20005) -> it_iliad_2124_hash
# CA table from it_iliad can be found here: https://cacombos.com/device/GVU6C?combolist=iliad_italy


# Pixel 7 (Pro) product line matrix (panther, cheetah)
#
# Android      Build Number            Release Date      SPC Carrier         CFG Version                        CFG Hash                                                              it_iliad_2124_hash
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 13.0.0       TD1A.220804.009.A2      Oct 2022          --------------      cfgdb-whipro-220812-B-8938343      2284622a32b772fa07470dd1027cb3e7c6e1f1b2ad0b48e19487cc1a0912f54c      9b1917cf0f87bc8ab95df0594fdf667446d6d985
# 13.0.0       TD1A.220804.009.A5      Oct 2022          JP carriers         ?                                  ?                                                                     ?
# 13.0.0       TD1A.220804.031         Oct 2022          --------------      cfgdb-whipro-220904-B-9027250      03ebb30965039c65f91e8720faf7f545200be0c9d530fa5181c58f93fef23176      3df4fd99b9a4e1910570d7a28d7f2d072f5c8277
# 13.0.0       TD1A.221105.001         Nov 2022          --------------      cfgdb-whipro-220904-B-9027250	    03ebb30965039c65f91e8720faf7f545200be0c9d530fa5181c58f93fef23176      3df4fd99b9a4e1910570d7a28d7f2d072f5c8277
# 13.0.0       TD1A.221105.001.A1      Nov 2022          Telia               ?                                  ?                                                                     ?
# 13.0.0       TD1A.221105.003         Nov 2022          Verizon             ?                                  ?                                                                     ?
# 13.0.0       TQ1A.221205.011         Dec 2022          --------------      cfgdb-whipro-221028-B-9229469      607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ1A.221205.012         Dec 2022          O2 UK               ?                                  ?                                                                     ?
# 13.0.0       TQ1A.230105.002         Jan 2023          --------------      cfgdb-whipro-221028-B-9229469      607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ1A.230105.002.A1      Jan 2023          Telstra             ?                                  ?                                                                     ?
# 13.0.0       TQ1A.230105.001.A2      Jan 2023          --------------      cfgdb-whipro-221028-B-9229469      607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ1A.230105.001.A3      Jan 2023          Telstra             ?                                  ?                                                                     ?
# 13.0.0       T2B2.221216.006         BETA2             QPR2 BETA2          cfgdb-whipro-221205-B-9369373      39ae49c010e94d6e1b98c088be1de336e899baa9c1d967fe4e91d135201307ce      f04fb8be538f925a3f27f095342ef54a69fac5a7


# Pixel 6a product line matrix (bluejay)
#
# Android      Build Number            Release Date      SPC Carrier         CFG Version                        CFG Hash                                                              it_iliad_2124_hash
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 12.1.0       SD2A.220601.001.A1      Jun 2022          JP carriers         ?                                  ?                                                                     ?
# 12.1.0       SD2A.220601.004         Jun 2022          Verizon             ?                                  ?                                                                     ?
# 12.1.0       SD2A.220601.002         Jun 2022          AT&T, T-Mobile      ?                                  ?                                                                     ?
# 12.1.0       SD2A.220601.003         Jun 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SD2A.220601.002.B1      Jul 2022          T-Mobile            ?                                  ?                                                                     ?
# 12.1.0       SD2A.220601.001.B1      Jul 2022          JP carriers         ?                                  ?                                                                     ?
# 12.1.0       SD2A.220601.003.B1      Jul 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SD2A.220601.004.B2      Jul 2022          Verizon             ?                                  ?                                                                     ?
# 13.0.0       TP1A.220624.021.A1      Aug 2022          --------------      ?                                  ?                                                                     ?
# 13.0.0       TP1A.220905.004.A2      Sep 2022          --------------      cfgdb-whi-220727-B-8875237         6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TP1A.221005.003         Oct 2022          --------------      cfgdb-whi-220830-B-9008086         c4e0af33779023aad5fb0ad1f363e88d9457456728f173f484ae463a54bd5522      48784c95ab72d90e641311d4dc9b6e8e59bf3dc7
# 13.0.0       TP1A.221105.002         Nov 2022          --------------      cfgdb-whi-220830-B-9008086         c4e0af33779023aad5fb0ad1f363e88d9457456728f173f484ae463a54bd5522      48784c95ab72d90e641311d4dc9b6e8e59bf3dc7
# 13.0.0       TQ1A.221205.011         Dec 2022          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.221205.012         Dec 2022          O2 UK               ?                                  ?                                                                     ?
# 13.0.0       TQ1A.230105.001.A2      Jan 2023          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       T2B2.221216.006         BETA2             QPR2 BETA2          cfgdb-whi-221208-B-9383952         0ea6f25ca5b445687d9a050f511ab8ba655fc25ec3cb9a6ab173059c0b9ded1f      9a3a75e21afe1d87ba22e958f590c37c5380ad8f


# Pixel 6 (Pro) product line matrix (oriole, raven)
#
# Android      Build Number            Release Date      SPC Carrier         CFG Version                        CFG Hash                                                              it_iliad_2124_hash
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 12.0.0       SD1A.210817.015.A4      Oct 2021          --------------      ?                                  ?                                                                     ?
# 12.0.0       SD1A.210817.019.B1      Oct 2021          AT&T                ?                                  ?                                                                     ?
# 12.0.0       SD1A.210817.019.C2      Oct 2021          US, CA, TW          ?                                  ?                                                                     ?
# 12.0.0       SD1A.210817.019.C4      Oct 2021          Verizon             ?                                  ?                                                                     ?
# 12.0.0       SD1A.210817.036         Nov 2021          --------------      cfgdb-wc-211005-B-7794072          e23b3f2cc6cc72441f3b6af561127a9747148fb99d4826c9208a09e9ee34e687      57e38baf9cbaf50389cdcac9dc657cc7bf074ba9
# 12.0.0       SD1A.210817.036.A8      Nov 2021          Verizon             ?                                  ?                                                                     ?
# 12.0.0       SD1A.210817.037         Nov 2021          --------------      cfgdb-wc-211005-B-7794072          e23b3f2cc6cc72441f3b6af561127a9747148fb99d4826c9208a09e9ee34e687      57e38baf9cbaf50389cdcac9dc657cc7bf074ba9
# 12.0.0       SD1A.210817.037.A1      Nov 2021          Verizon             ?                                  ?                                                                     ?
# 12.0.0       SQ1D.220105.007         Jan 2022          --------------      cfgdb-wc-211223-B-8025189          810659bcda157c0b909ef344b423aaacca94fcea9f4f80d8ba6632339caaafb7      298dd4caed820e9be0d0009816c5fe83f5ceab28
# 12.0.0       SQ1D.220205.003         Feb 2022          --------------      cfgdb-wc-211223-B-8025189          810659bcda157c0b909ef344b423aaacca94fcea9f4f80d8ba6632339caaafb7      298dd4caed820e9be0d0009816c5fe83f5ceab28
# 12.0.0       SQ1D.220205.004         Feb 2022          --------------      cfgdb-whi-220211-B-8174161         dfacdfc652f2407b04a9772af126b49112a49980e46c775823921dd9d2a8c4d4      b7bcdffc7475e6d00dda1cff7bf57b82be03a40b
# 12.1.0       SP2A.220305.013.A3      Mar 2022          --------------      cfgdb-whi-220211-B-8174161         dfacdfc652f2407b04a9772af126b49112a49980e46c775823921dd9d2a8c4d4      b7bcdffc7475e6d00dda1cff7bf57b82be03a40b
# 12.1.0       SP2A.220405.004         Apr 2022          --------------      cfgdb-whi-220211-B-8174161         dfacdfc652f2407b04a9772af126b49112a49980e46c775823921dd9d2a8c4d4      b7bcdffc7475e6d00dda1cff7bf57b82be03a40b
# 12.1.0       SP2A.220505.002         May 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220605.009.A1      Jun 2022          Verizon             ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220605.009.B1      Jun 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220705.001.B1      Jul 2022          EMEA/APAC           ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220705.003         Jul 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220705.003.A1      Jul 2022          Verizon             ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220705.003.A3      Jul 2022          Verizon             ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220705.004         Jul 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220705.004.A1      Jul 2022          Softbank            ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220705.001.B2      Jul 2022          EMEA                ?                                  ?                                                                     ?
# 13.0.0       TP1A.220624.021         Aug 2022          --------------      ?                                  ?                                                                     ?
# 13.0.0       TP1A.220905.004         Sep 2022          --------------      cfgdb-whi-220727-B-8875237         6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TP1A.220905.004.A1      Sep 2022          Verizon             ?                                  ?                                                                     ?
# 13.0.0       TP1A.221005.002         Oct 2022          --------------      cfgdb-whi-220727-B-8875237         6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TP1A.221105.002         Nov 2022          --------------      cfgdb-whi-220727-B-8875237         6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TQ1A.221205.011         Dec 2022          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.230105.002         Jan 2023          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       T2B2.221216.006         BETA2             QPR2 BETA2          cfgdb-whi-221208-B-9383952         0ea6f25ca5b445687d9a050f511ab8ba655fc25ec3cb9a6ab173059c0b9ded1f      9a3a75e21afe1d87ba22e958f590c37c5380ad8f


    # Pixel 7 (Pro) product line (panther, cheetah)
if [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVERSION" == "cfgdb-whipro-221205-B-9369373" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_7/cfgdb-whipro-221205-B-9369373/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVERSION" == "cfgdb-whipro-221028-B-9229469" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_7/cfgdb-whipro-221028-B-9229469/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"


    # Pixel 6/6a (Pro) product line (oriole, raven, bluejay)
elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-221208-B-9383952" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-221208-B-9383952/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-221101-B-9242015" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-221101-B-9242015/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-220830-B-9008086" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-220830-B-9008086/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-220727-B-8875237" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-220727-B-8875237/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

else
    ui_print "- Device is: $CODENAME"
    ui_print "- CFG version is: $CFGVERION"
    ui_print "- CFG file is in the state: $CFGHASH"
    abort    "- Your device, config file or ROM build unsupported yet!"
fi

rm -rf $MODPATH/cfgs/
