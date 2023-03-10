if $BOOTMODE; then
    ui_print "- Installing from Magisk app"
else
    ui_print "*********************************************************"
    ui_print "! Install from recovery is NOT supported"
    ui_print "! Please install from Magisk app"
    abort    "*********************************************************"
fi

ui_print "- Magisk version is: $MAGISK_VER_CODE"

CODENAME=$(getprop ro.product.vendor.device)
BUILDID=$(getprop ro.vendor.build.id)
CFGVERSION=$(cat /vendor/firmware/carrierconfig/release-label)
CFGHASH=$(toybox sha256sum -b /vendor/firmware/carrierconfig/cfg.db)


# In this module we try to fix LTE restrictions on non-certified
# (actually CIS) networks for Google Tensor devices by force set
# "it_iliad (2124)" config as the best discovered solution for this networks to the default
# WILDCARD (0), PTCRB (20001) and  PTCRB_ROW (20005) configs under this pattern:
# confnames -> it_iliad -> 2124 -> confmap -> 2124_as_hash -> WILDCARD (0) / PTCRB (20001) / PTCRB_ROW (20005) -> it_iliad_2124_hash
# CA table from "it_iliad (2124)" config can be found here: https://cacombos.com/device/GVU6C?combolist=iliad_italy
# !!!!!!!!!! CA combinations currently not implemented !!!!!!!!!!


# Pixel 7 (Pro) product line matrix (panther, cheetah)
#
# Android      Build Number            Release Date      SPC Carrier         CFG Version                        CFG SHA-256 Hash                                                      it_iliad_2124_hash
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 13.0.0       TD1A.220804.009.A2      Oct 2022          --------------      cfgdb-whipro-220812-B-8938343      2284622a32b772fa07470dd1027cb3e7c6e1f1b2ad0b48e19487cc1a0912f54c      9b1917cf0f87bc8ab95df0594fdf667446d6d985
# 13.0.0       TD1A.220804.031         Oct 2022          --------------      cfgdb-whipro-220904-B-9027250      03ebb30965039c65f91e8720faf7f545200be0c9d530fa5181c58f93fef23176      3df4fd99b9a4e1910570d7a28d7f2d072f5c8277
# 13.0.0       TD1A.221105.001         Nov 2022          --------------      cfgdb-whipro-220904-B-9027250	    03ebb30965039c65f91e8720faf7f545200be0c9d530fa5181c58f93fef23176      3df4fd99b9a4e1910570d7a28d7f2d072f5c8277
# 13.0.0       TQ1A.221205.011         Dec 2022          --------------      cfgdb-whipro-221028-B-9229469      607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ1A.230105.002         Jan 2023          --------------      cfgdb-whipro-221028-B-9229469      607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ1A.230105.001.A2      Jan 2023          --------------      cfgdb-whipro-221028-B-9229469      607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       TQ1A.230205.002         Feb 2023          --------------      cfgdb-whipro-221028-B-9229469      607a87c1b5e9ca28e6e400a32a1cb67fa8b11284d2240118870e65a059eac1c0      744f716abbb52eeea16696a35d5d4b111a9f0609
# 13.0.0       T2B2.221216.006         BETA 2            QPR2 BETA 2         cfgdb-whipro-221205-B-9369373      39ae49c010e94d6e1b98c088be1de336e899baa9c1d967fe4e91d135201307ce      f04fb8be538f925a3f27f095342ef54a69fac5a7
# 13.0.0       T2B2.221216.008         BETA 2.1          QPR2 BETA 2.1       cfgdb-whipro-230111-B-9477992      cba12a031dba5fde91b57a5ece7969a5b802b7821abfa16530144913398911e7      a14f2bdb495010e01b269a41057793f19229f0ac
# 13.0.0       T2B3.230109.002         BETA 3            QPR2 BETA 3         cfgdb-whipro-230118-B-9499472      d19b571924df769c05f12de696b8294b6c6c028d05e2e566b00d6f88701b76c3      a14f2bdb495010e01b269a41057793f19229f0ac
# 13.0.0       T2B3.230109.004         BETA 3.1          QPR2 BETA 3.1       cfgdb-whipro-230126-B-9528706      644fda00e964d03e6ab760e57850f2f5d0d16c8f16c209eb8070c2ffdae570ff      a14f2bdb495010e01b269a41057793f19229f0ac


# Pixel 6a product line matrix (bluejay)
#
# Android      Build Number            Release Date      SPC Carrier         CFG Version                        CFG SHA-256 Hash                                                      it_iliad_2124_hash
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 12.1.0       SD2A.220601.003         Jun 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SD2A.220601.003.B1      Jul 2022          --------------      ?                                  ?                                                                     ?
# 13.0.0       TP1A.220624.021.A1      Aug 2022          --------------      ?                                  ?                                                                     ?
# 13.0.0       TP1A.220905.004.A2      Sep 2022          --------------      cfgdb-whi-220727-B-8875237         6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TP1A.221005.003         Oct 2022          --------------      cfgdb-whi-220830-B-9008086         c4e0af33779023aad5fb0ad1f363e88d9457456728f173f484ae463a54bd5522      48784c95ab72d90e641311d4dc9b6e8e59bf3dc7
# 13.0.0       TP1A.221105.002         Nov 2022          --------------      cfgdb-whi-220830-B-9008086         c4e0af33779023aad5fb0ad1f363e88d9457456728f173f484ae463a54bd5522      48784c95ab72d90e641311d4dc9b6e8e59bf3dc7
# 13.0.0       TQ1A.221205.011         Dec 2022          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.230105.001.A2      Jan 2023          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.230205.002         Feb 2023          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       T2B2.221216.006         BETA 2            QPR2 BETA 2         cfgdb-whi-221208-B-9383952         0ea6f25ca5b445687d9a050f511ab8ba655fc25ec3cb9a6ab173059c0b9ded1f      9a3a75e21afe1d87ba22e958f590c37c5380ad8f
# 13.0.0       T2B2.221216.008         BETA 2.1          QPR2 BETA 2.1       cfgdb-whi-230111-B-9477400         adff2f11e470f16cb165e6e14361fce31b8f601fd928766b66d4ce548391a46a      d09e83c013e416297cbbbe6f9535a5a050086b42
# 13.0.0       T2B3.230109.002         BETA 3            QPR2 BETA 3         cfgdb-whi-230118-B-9499963         e8c12c63239b974a757ba7ccfa822be2ff5299a38ea6316a0857d5d6ae2a5761      d09e83c013e416297cbbbe6f9535a5a050086b42
# 13.0.0       T2B3.230109.004         BETA 3.1          QPR2 BETA 3.1       cfgdb-whi-230126-B-9529970         bb554f10d7a4f2342118755f186ccc2cd458b95e9531e1742e72ec03a2f2c63d      d09e83c013e416297cbbbe6f9535a5a050086b42


# Pixel 6 (Pro) product line matrix (oriole, raven)
#
# Android      Build Number            Release Date      SPC Carrier         CFG Version                        CFG SHA-256 Hash                                                      it_iliad_2124_hash
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 12.0.0       SD1A.210817.015.A4      Oct 2021          --------------      ?                                  ?                                                                     ?
# 12.0.0       SD1A.210817.036         Nov 2021          --------------      cfgdb-wc-211005-B-7794072          e23b3f2cc6cc72441f3b6af561127a9747148fb99d4826c9208a09e9ee34e687      57e38baf9cbaf50389cdcac9dc657cc7bf074ba9
# 12.0.0       SD1A.210817.037         Nov 2021          --------------      cfgdb-wc-211005-B-7794072          e23b3f2cc6cc72441f3b6af561127a9747148fb99d4826c9208a09e9ee34e687      57e38baf9cbaf50389cdcac9dc657cc7bf074ba9
# 12.0.0       SQ1D.220105.007         Jan 2022          --------------      cfgdb-wc-211223-B-8025189          810659bcda157c0b909ef344b423aaacca94fcea9f4f80d8ba6632339caaafb7      298dd4caed820e9be0d0009816c5fe83f5ceab28
# 12.0.0       SQ1D.220205.003         Feb 2022          --------------      cfgdb-wc-211223-B-8025189          810659bcda157c0b909ef344b423aaacca94fcea9f4f80d8ba6632339caaafb7      298dd4caed820e9be0d0009816c5fe83f5ceab28
# 12.0.0       SQ1D.220205.004         Feb 2022          --------------      cfgdb-whi-220211-B-8174161         dfacdfc652f2407b04a9772af126b49112a49980e46c775823921dd9d2a8c4d4      b7bcdffc7475e6d00dda1cff7bf57b82be03a40b
# 12.1.0       SP2A.220305.013.A3      Mar 2022          --------------      cfgdb-whi-220211-B-8174161         dfacdfc652f2407b04a9772af126b49112a49980e46c775823921dd9d2a8c4d4      b7bcdffc7475e6d00dda1cff7bf57b82be03a40b
# 12.1.0       SP2A.220405.004         Apr 2022          --------------      cfgdb-whi-220211-B-8174161         dfacdfc652f2407b04a9772af126b49112a49980e46c775823921dd9d2a8c4d4      b7bcdffc7475e6d00dda1cff7bf57b82be03a40b
# 12.1.0       SP2A.220505.002         May 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220605.009.B1      Jun 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220705.003         Jul 2022          --------------      ?                                  ?                                                                     ?
# 12.1.0       SQ3A.220705.004         Jul 2022          --------------      ?                                  ?                                                                     ?
# 13.0.0       TP1A.220624.021         Aug 2022          --------------      ?                                  ?                                                                     ?
# 13.0.0       TP1A.220905.004         Sep 2022          --------------      cfgdb-whi-220727-B-8875237         6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TP1A.221005.002         Oct 2022          --------------      cfgdb-whi-220727-B-8875237         6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TP1A.221105.002         Nov 2022          --------------      cfgdb-whi-220727-B-8875237         6ecc715d2ea0e95ee0bd5a2ba6c70f4be8f6c88dd63cab4202c809c65547447f      b2e59690a19dc17b37ca331e2db59903591a6a22
# 13.0.0       TQ1A.221205.011         Dec 2022          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.230105.002         Jan 2023          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       TQ1A.230205.002         Feb 2023          --------------      cfgdb-whi-221101-B-9242015         1c623e91b285306015b4387d92d26dd3d1f7d78efe1506c42d6f3e6375c00dd0      c7dead7b478f240cf3e3ac42873af315b6d715df
# 13.0.0       T2B2.221216.006         BETA 2            QPR2 BETA 2         cfgdb-whi-221208-B-9383952         0ea6f25ca5b445687d9a050f511ab8ba655fc25ec3cb9a6ab173059c0b9ded1f      9a3a75e21afe1d87ba22e958f590c37c5380ad8f
# 13.0.0       T2B2.221216.008         BETA 2.1          QPR2 BETA 2.1       cfgdb-whi-230111-B-9477400         adff2f11e470f16cb165e6e14361fce31b8f601fd928766b66d4ce548391a46a      d09e83c013e416297cbbbe6f9535a5a050086b42
# 13.0.0       T2B3.230109.002         BETA 3            QPR2 BETA 3         cfgdb-whi-230118-B-9499963         e8c12c63239b974a757ba7ccfa822be2ff5299a38ea6316a0857d5d6ae2a5761      d09e83c013e416297cbbbe6f9535a5a050086b42
# 13.0.0       T2B3.230109.004         BETA 3.1          QPR2 BETA 3.1       cfgdb-whi-230126-B-9529970         bb554f10d7a4f2342118755f186ccc2cd458b95e9531e1742e72ec03a2f2c63d      d09e83c013e416297cbbbe6f9535a5a050086b42


    # Pixel 7 (Pro) product line (panther, cheetah)
if [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVERSION" == "cfgdb-whipro-230126-B-9528706" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_7/cfgdb-whipro-230126-B-9528706/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVERSION" == "cfgdb-whipro-230118-B-9499472" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_7/cfgdb-whipro-230118-B-9499472/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVERSION" == "cfgdb-whipro-230111-B-9477992" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_7/cfgdb-whipro-230111-B-9477992/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVERSION" == "cfgdb-whipro-221205-B-9369373" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_7/cfgdb-whipro-221205-B-9369373/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "panther" ] || [ "$CODENAME" == "cheetah" ] && [ "$CFGVERSION" == "cfgdb-whipro-221028-B-9229469" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_7/cfgdb-whipro-221028-B-9229469/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"


    # Pixel 6/6a (Pro) product line (oriole, raven, bluejay)
elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-230126-B-9529970" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-230126-B-9529970/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-230118-B-9499963" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-230118-B-9499963/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-230111-B-9477400" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-230111-B-9477400/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-221208-B-9383952" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-221208-B-9383952/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-221101-B-9242015" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-221101-B-9242015/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-220830-B-9008086" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-220830-B-9008086/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

elif [ "$CODENAME" == "raven" ] || [ "$CODENAME" == "oriole" ] || [ "$CODENAME" == "bluejay" ] && [ "$CFGVERSION" == "cfgdb-whi-220727-B-8875237" ]; then
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file is in the state: $CFGHASH"
    cp -r "$MODPATH/cfgs/pixel_6/cfgdb-whi-220727-B-8875237/cfg.db" "$MODPATH/system/vendor/firmware/carrierconfig/"

else
    ui_print "- Device is: $CODENAME"
    ui_print "- Build ID is: $BUILDID"
    ui_print "- CFG version is: $CFGVERSION"
    ui_print "- CFG file state is: $CFGHASH"
    ui_print "- This module is only for Google Tensor devices!"
    abort    "- Your device, config file or ROM build unsupported yet!"
fi

rm -rf $MODPATH/cfgs/
