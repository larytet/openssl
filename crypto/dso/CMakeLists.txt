CYREN_INSTALL_HEADERS(dso.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    dso_dl.c
    dso_dlfcn.c
    dso_err.c
    dso_lib.c
    dso_null.c
    dso_openssl.c
    dso_win32.c
    dso_vms.c
    dso_beos.c
    PARENT_SCOPE)
