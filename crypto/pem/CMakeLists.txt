CYREN_INSTALL_HEADERS(pem.h pem2.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    pem_sign.c
    pem_seal.c
    pem_info.c
    pem_lib.c
    pem_all.c
    pem_err.c
    pem_x509.c
    pem_xaux.c
    pem_oth.c
    pem_pk8.c
    pem_pkey.c
    pvkfmt.c
    PARENT_SCOPE)
