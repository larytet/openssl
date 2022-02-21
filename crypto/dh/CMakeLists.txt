CYREN_INSTALL_HEADERS(dh.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    dh_asn1.c
    dh_gen.c
    dh_key.c
    dh_lib.c
    dh_check.c
    dh_err.c
    dh_depr.c
    dh_ameth.c
    dh_pmeth.c
    dh_prn.c
    dh_rfc5114.c
    dh_kdf.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    dhtest.c
    PARENT_SCOPE)
