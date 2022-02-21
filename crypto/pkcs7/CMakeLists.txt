CYREN_INSTALL_HEADERS(pkcs7.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    pk7_asn1.c
    pk7_lib.c
    pkcs7err.c
    pk7_doit.c
    pk7_smime.c
    pk7_attr.c
    pk7_mime.c
    bio_pk7.c
    PARENT_SCOPE)
