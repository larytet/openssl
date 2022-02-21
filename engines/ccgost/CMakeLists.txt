ADD_LIBRARY(gost SHARED
    e_gost_err.c
    gost2001.c
    gost2001_keyx.c
    gost89.c
    gost94_keyx.c
    gost_ameth.c
    gost_asn1.c
    gost_crypt.c
    gost_ctl.c
    gost_eng.c
    gosthash.c
    gost_keywrap.c
    gost_md.c
    gost_params.c
    gost_pmeth.c
    gost_sign.c)

SET_TARGET_PROPERTIES(gost PROPERTIES
    VERSION "1.0.0"
    SOVERSION "1")

TARGET_LINK_LIBRARIES(gost crypto)
