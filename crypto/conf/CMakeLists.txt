CYREN_INSTALL_HEADERS(conf.h conf_api.h PREFIX openssl)
CYREN_INSTALL_HEADERS(conf_def.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    conf_err.c
    conf_lib.c
    conf_api.c
    conf_def.c
    conf_mod.c
    conf_mall.c
    conf_sap.c
    PARENT_SCOPE)
