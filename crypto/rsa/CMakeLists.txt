CYREN_INSTALL_HEADERS(rsa.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    rsa_eay.c
    rsa_gen.c
    rsa_lib.c
    rsa_sign.c
    rsa_saos.c
    rsa_err.c
    rsa_pk1.c
    rsa_ssl.c
    rsa_none.c
    rsa_oaep.c
    rsa_chk.c
    rsa_null.c
    rsa_pss.c
    rsa_x931.c
    rsa_asn1.c
    rsa_depr.c
    rsa_ameth.c
    rsa_prn.c
    rsa_pmeth.c
    rsa_crpt.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    rsa_test.c
    PARENT_SCOPE)
