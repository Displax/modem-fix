# Universal Modem Fix

> **Warning**
> Work In progress

Fix LTE restrictions on non-certified (actually CIS) networks for Google Tensor devices.

In this module we try to fix LTE restrictions on non-certified (actually CIS) networks for Google Tensor devices by force set "it_iliad (2124)" config as the best discovered solution for this networks to the default WILDCARD (0), PTCRB (20001) and  PTCRB_ROW (20005) configs under this pattern:  
confnames -> it_iliad -> 2124 -> confmap -> 2124_as_hash -> WILDCARD (0) / PTCRB (20001) / PTCRB_ROW (20005) -> it_iliad_2124_hash  

CA table from "it_iliad (2124)" config can be found here: https://cacombos.com/device/GVU6C?combolist=iliad_italy

!!!!!!!!!! CA combinations currently not implemented !!!!!!!!!!
