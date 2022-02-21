CYREN_INSTALL_HEADERS(objects.h obj_mac.h PREFIX openssl)
CYREN_INSTALL_HEADERS(obj_dat.h obj_xref.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    o_names.c
    obj_dat.c
    obj_lib.c
    obj_err.c
    obj_xref.c
    PARENT_SCOPE)
