CYREN_INSTALL_HEADERS(dsa.h PREFIX openssl)
CYREN_INSTALL_HEADERS(dsa_locl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    dsa_gen.c
    dsa_key.c
    dsa_lib.c
    dsa_asn1.c
    dsa_vrf.c
    dsa_sign.c
    dsa_err.c
    dsa_ossl.c
    dsa_depr.c
    dsa_ameth.c
    dsa_pmeth.c
    dsa_prn.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    dsatest.c
    PARENT_SCOPE)
